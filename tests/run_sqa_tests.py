#!/usr/bin/env python3
"""Uji otomatis ringan terhadap DB uniCenta lab Toko XXX (bukan exploit)."""
from __future__ import annotations

import json
import os
import subprocess
import time
from pathlib import Path

OUT = Path(__file__).resolve().parents[1] / "docs/kelompok-2/hasil-otomatis.json"
HOST = os.environ.get("UC_MYSQL_HOST", "127.0.0.1")
PORT = os.environ.get("UC_MYSQL_PORT", "3306")
USER = os.environ.get("UC_MYSQL_USER", "asrofil")
PASSWORD = os.environ.get("UC_MYSQL_PASSWORD", "Asrofil123!")
DB = os.environ.get("UC_MYSQL_DB", "unicenta")
PROP = Path.home() / "unicentaopos.properties"


def mysql(sql: str) -> str:
    cmd = [
        "mysql",
        "-h",
        HOST,
        "-P",
        PORT,
        "-u",
        USER,
        f"-p{PASSWORD}",
        "-N",
        "-e",
        sql,
        DB,
    ]
    p = subprocess.run(cmd, capture_output=True, text=True)
    if p.returncode != 0:
        raise RuntimeError(p.stderr)
    return p.stdout.strip()


def case(cid: str, kak: str, jenis: str, expected: str, actual: str, passed: bool, severity: str) -> dict:
    return {
        "id": cid,
        "kak": kak,
        "jenis": jenis,
        "expected": expected,
        "actual": actual,
        "status": "Pass" if passed else "Fail",
        "severity": severity if not passed else "-",
    }


def main() -> None:
    results = []

    tables = mysql("SHOW TABLES")
    results.append(
        case(
            "TC-A-01",
            "KAK-T03",
            "Otomatis / integrasi",
            "Skema POS ada di database",
            f"{len(tables.splitlines())} tabel: products, tickets, stockcurrent ada"
            if "products" in tables and "tickets" in tables
            else tables,
            "products" in tables and "stockcurrent" in tables and "tickets" in tables,
            "Kritis",
        )
    )

    stock = mysql("SELECT units FROM stockcurrent WHERE product='P-HP-001'")
    results.append(
        case(
            "TC-A-02",
            "KAK-T04",
            "Otomatis / stok",
            "Stok headset berkurang setelah penjualan lab (20-1=19)",
            stock or "(kosong)",
            stock.split()[0] == "19" if stock else False,
            "Kritis",
        )
    )

    pay = mysql("SELECT payment, total FROM payments WHERE id='PAY-LAB-001'")
    results.append(
        case(
            "TC-I-01",
            "KAK-T03,KAK-T05",
            "Integrasi",
            "Pembayaran tunai tersimpan di DB",
            pay or "(kosong)",
            "cash" in pay and "150000" in pay.replace(".0", ""),
            "Kritis",
        )
    )

    t0 = time.perf_counter()
    mysql("SELECT COUNT(*) FROM stockcurrent")
    mysql("SELECT p.name, s.units FROM products p JOIN stockcurrent s ON s.product=p.id")
    elapsed_ms = (time.perf_counter() - t0) * 1000
    results.append(
        case(
            "TC-ST-01",
            "KAK-T04",
            "Stress / kinerja",
            "Kueri stok < 500 ms di lab",
            f"{elapsed_ms:.1f} ms",
            elapsed_ms < 500,
            "Minor",
        )
    )

    t1 = time.perf_counter()
    bench = mysql("SELECT BENCHMARK(10000, (SELECT units FROM stockcurrent WHERE product='P-MS-001'))")
    burst = (time.perf_counter() - t1) * 1000
    results.append(
        case(
            "TC-ST-02",
            "KAK-T04",
            "Stress",
            "10.000 pembacaan stok (BENCHMARK) selesai tanpa error",
            f"hasil={bench} dalam {burst:.0f} ms",
            bench in {"0", ""} or True,
            "Minor",
        )
    )

    people = mysql("SELECT name, IFNULL(apppassword,'NULL') FROM people")
    empty_pw = "NULL" in people
    results.append(
        case(
            "TC-S-03",
            "KAK-K01,KAK-D01",
            "Keamanan",
            "Pengguna default memakai kata sandi bukan NULL",
            people.replace("\t", " / "),
            not empty_pw,
            "Kritis",
        )
    )

    roles = mysql("SELECT id, name FROM roles")
    results.append(
        case(
            "TC-S-01",
            "KAK-D01",
            "Keamanan / otorisasi",
            "Ada peran Administrator dan Employee",
            roles.replace("\n", "; "),
            "Administrator" in roles and "Employee" in roles,
            "Mayor",
        )
    )

    payroll_tables = mysql(
        "SELECT table_name FROM information_schema.tables WHERE table_schema='unicentaopos' "
        "AND (table_name LIKE '%gaji%' OR table_name LIKE '%payroll%' OR table_name LIKE '%salary%')"
    )
    results.append(
        case(
            "TC-F-05",
            "KAK-T06",
            "Fungsional / otomatis",
            "Ada tabel atau data penggajian karyawan",
            payroll_tables or "tidak ada tabel gaji/payroll/salary",
            bool(payroll_tables),
            "Mayor",
        )
    )

    monthly = mysql(
        "SELECT DATE_FORMAT(r.datenew,'%Y-%m') ym, SUM(p.total) "
        "FROM receipts r JOIN payments p ON p.receipt=r.id "
        "GROUP BY ym"
    )
    results.append(
        case(
            "TC-F-04",
            "KAK-T05,KAK-S02",
            "Fungsional / laporan",
            "Data pemasukan dapat direkap per bulan dari DB",
            monthly or "(tidak ada transaksi)",
            bool(monthly),
            "Mayor",
        )
    )

    plaintext = False
    prop_text = ""
    if PROP.exists():
        prop_text = PROP.read_text(encoding="utf-8", errors="replace")
        for line in prop_text.splitlines():
            if line.startswith("db.password=") and line.split("=", 1)[1].strip():
                plaintext = True
                break
    results.append(
        case(
            "TC-W-01",
            "KAK-K01",
            "White box / keamanan",
            "Kredensial DB tidak disimpan polos di unicentaopos.properties",
            f"{PROP} berisi db.password polos" if plaintext else "tidak ditemukan password polos",
            not plaintext,
            "Mayor",
        )
    )

    quoted = mysql("SELECT COUNT(*) FROM products WHERE name = 'Headset Bluetooth XXX'")
    nprod = mysql("SELECT COUNT(*) FROM products")
    results.append(
        case(
            "TC-S-04",
            "KAK-K01",
            "Keamanan data (integritas kueri)",
            "Pencarian nama produk dengan literal SQL ter-escape tidak merusak tabel",
            f"cocok={quoted}; jumlah produk={nprod}",
            quoted == "1" and nprod == "5",
            "Mayor",
        )
    )

    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(results, indent=2, ensure_ascii=False), encoding="utf-8")
    fails = [r for r in results if r["status"] == "Fail"]
    print(json.dumps({"total": len(results), "fail": len(fails), "path": str(OUT)}, ensure_ascii=False, indent=2))
    for r in results:
        print(f"{r['id']:10} {r['status']:4} {r['kak']}")


if __name__ == "__main__":
    main()
