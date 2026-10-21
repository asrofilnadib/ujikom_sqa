#!/usr/bin/env python3
"""Build one-PDF-per-deck by converting each slide HTML separately, then gs merge."""
from __future__ import annotations

import subprocess
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
PPT = ROOT / "docs/ppt"
PDF = ROOT / "docs/pdf"

STYLE = """
body { font-family: "Liberation Sans", Arial, sans-serif; color: #1a1a1a; margin: 16mm; }
h1 { font-size: 22pt; margin: 0 0 8mm; line-height: 1.25; }
h2 { font-size: 16pt; margin: 0 0 6mm; color: #1f4e79; }
p, li, td { font-size: 14pt; }
.kicker { font-size: 12pt; color: #1f4e79; margin-bottom: 6mm; }
.meta { color: #555; font-size: 12pt; }
table { border-collapse: collapse; width: 100%; }
th, td { border: 1px solid #ccc; padding: 3mm; text-align: left; vertical-align: top; }
th { background: #1f4e79; color: #fff; }
.fail { color: #8b0000; font-weight: 700; }
"""

DECKS = {
    "01-rencana-kualitas": [
        """<div class="kicker">Kelompok 1 · SQA Pre Development · 10 menit</div>
        <h1>Rencana mutu POS Toko XXX</h1>
        <p class="meta">Organisasi XYZ · uniCenta oPOS sebagai kandidat produk · 21 Oktober 2026<br/>Skema SS-LSP.UEU-002-2020 · IEEE 730 · ISO 25010 · ISO 12207 · ISO/IEC/IEEE 29119</p>
        <p>SQA tidak mengganti waterfall di KAK. SQA menempelkan gerbang mutu di setiap akhir fase, dengan ID kebutuhan yang sama sampai ke kasus uji.</p>""",
        """<h2>1. Metodologi dan kerangka</h2>
        <table><tr><th>Lapisan</th><th>Standar</th><th>Dipakai untuk</th></tr>
        <tr><td>Rencana SQA</td><td>IEEE 730</td><td>SQAP, peran, catatan</td></tr>
        <tr><td>Siklus hidup</td><td>ISO 12207 + waterfall KAK</td><td>Gerbang Requirements sampai Maintenance</td></tr>
        <tr><td>Mutu produk</td><td>ISO 25010</td><td>Fungsi, stok, keamanan, usability</td></tr>
        <tr><td>Pengujian</td><td>ISO 29119</td><td>Skenario, matriks, selesai uji</td></tr></table>
        <p>Independensi: SQA tidak merangkap programmer.</p>""",
        """<h2>2. Lingkup produk dan proses</h2>
        <p><strong>Wajib lulus:</strong> ganti Excel (T01), catat transaksi ke DB (T02–T03), stok real time (T04), laporan pemasukan/pengeluaran bulanan (T05/S02), <strong>gaji karyawan (T06)</strong>, peran karyawan/admin (D01).</p>
        <p><strong>Proses:</strong> tidak ada fase tumpang tindih (KAK-W). Exit criteria tertulis. Dokumentasi, manual bergambar, garansi 3 bulan termasuk lingkup.</p>
        <p><strong>Di luar lingkup:</strong> hardware printer, toko daring, sertifikasi ISO organisasi.</p>""",
        """<h2>3. Pelaksanaan 45 hari dan RACI</h2>
        <table><tr><th>Minggu</th><th>Fase</th><th>Keluaran SQA</th></tr>
        <tr><td>1</td><td>Requirements</td><td>SQAP, RTM, laporan pendahuluan</td></tr>
        <tr><td>2–3</td><td>Design</td><td>Review arsitektur/UI/data</td></tr>
        <tr><td>4–6</td><td>Implementation</td><td>Build lab, cek rahasia</td></tr>
        <tr><td>7–8</td><td>Verification</td><td>Uji + defect</td></tr>
        <tr><td>9 + 3 bln</td><td>Serah terima / garansi</td><td>UAT, manual, regresi</td></tr></table>
        <p>PM akuntabel rilis. SQA responsible uji. Pemilik Toko XXX memutus serah terima.</p>""",
        """<h2>4. Risiko, perubahan, DoD</h2>
        <p><strong>Risiko tertinggi:</strong> gaji tidak diimplementasi (R01), stok salah (R02), laporan tidak otomatis (R03), bocor data (R04), waterfall vs change (R05).</p>
        <p><strong>Perubahan:</strong> CCB (PM, Designer, SQA, pemilik). Impact analysis, regresi, versi. Garansi 3 bulan: defect kritis 5 hari kerja.</p>
        <p><strong>Definition of Done:</strong> 100% kasus wajib dieksekusi, 0 defect kritis, deliverable D02–D05 ada. Tanpa itu produk tidak dirilis.</p>""",
    ],
    "02-hasil-pengujian": [
        """<div class="kicker">Kelompok 2 · SQA Development · 5 menit</div>
        <h1>Hasil uji uniCenta vs KAK</h1>
        <p>Lingkungan 21 Oktober 2026: Ubuntu 24.04, MySQL 8.0 lokal port 3306, data dummy toko elektronik.</p>
        <p>Verifikasi tahap: produk jadi dapat diuji, tetapi jejak waterfall vendor <strong>tidak lengkap</strong>. Verification tetap jalan sesuai kriteria masuk SQAP.</p>
        <p>21 kasus (manual + otomatis + white box + keamanan). Ringkasan defect: 1 kritis, 6 mayor terbuka.</p>""",
        """<h2>Yang lulus</h2>
        <table><tr><th>Kebutuhan</th><th>Bukti</th></tr>
        <tr><td>T01 POS menggantikan Excel</td><td>Aplikasi native start, JDBC_OK</td></tr>
        <tr><td>T03 transaksi di database</td><td>52 tabel; tiket lab tersimpan</td></tr>
        <tr><td>T04 stok real time</td><td>Headset 20 → 19 setelah 1 penjualan</td></tr>
        <tr><td>D01 peran</td><td>Administrator, Manager, Employee, Guest</td></tr>
        <tr><td>Integrasi / stress</td><td>cash 150000; BENCHMARK 10k stok 125 ms</td></tr></table>""",
        """<h2>Yang gagal — jangan diluluskan diam-diam</h2>
        <table><tr><th>ID</th><th>Temuan</th><th>Keparahan</th></tr>
        <tr><td>T06</td><td class="fail">Tidak ada modul/tabel gaji (DEF-01)</td><td>Mayor / wajib KAK</td></tr>
        <tr><td>K01 / D01</td><td class="fail">Semua user default password NULL (DEF-02)</td><td>Kritis</td></tr>
        <tr><td>K01</td><td class="fail">db.password polos di properties (DEF-03)</td><td>Mayor</td></tr>
        <tr><td>T05 / S02</td><td>Pemasukan ada; pengeluaran otomatis tidak lengkap</td><td>Mayor</td></tr>
        <tr><td>D02–D05</td><td>Manual bergambar dan garansi 3 bulan tidak ada</td><td>Mayor</td></tr></table>
        <p>Gerbang rilis SQAP: <span class="fail">tidak lulus</span> (ada kritis + T06 Fail).</p>""",
    ],
    "03-rekomendasi": [
        """<div class="kicker">Kelompok 3 · SQA Post Development · 5 menit</div>
        <h1>Rekomendasi ke stakeholder</h1>
        <p>Kesesuaian: kasir, stok, dan DB <strong>ada</strong>. Gaji, kerahasiaan, manual, garansi <strong>tidak memenuhi KAK</strong>.</p>
        <p>SQA tidak merekomendasikan serah terima penuh sekarang.</p>""",
        """<h2>Korektif (perbaiki produk)</h2>
        <table><tr><th>Kode</th><th>Tindakan</th><th>Jika tidak</th></tr>
        <tr><td>KOR-01</td><td>Wajibkan password; tutup Guest</td><td>Admin bebas diakses di kasir</td></tr>
        <tr><td>KOR-02</td><td>Modul gaji atau payroll terpisah + adendum</td><td>T06 gagal; Excel tetap</td></tr>
        <tr><td>KOR-03</td><td>Jangan simpan password DB polos</td><td>Bocor seluruh database</td></tr>
        <tr><td>KOR-04</td><td>Laporan pengeluaran + rekap bulanan</td><td>S02 tidak tercapai</td></tr>
        <tr><td>KOR-05/06</td><td>Manual bergambar Indonesia + garansi 3 bulan</td><td>D04/K03 gagal</td></tr></table>""",
        """<h2>Preventif dan sistem uji ke depan</h2>
        <ul>
        <li>PRE-01: gap analysis fitur vs KAK sebelum Design ditutup (akar T06).</li>
        <li>PRE-02: DoD = 100% T wajib Pass, 0 kritis.</li>
        <li>PRE-03: checklist keamanan di gerbang Implementation.</li>
        <li>Regresi: pertahankan tests/run_sqa_tests.py; tambah checklist GUI Swing (bukan Selenium palsu).</li>
        <li>UAT pemilik memakai skenario T01–T06, bukan menu vendor Inggris.</li>
        </ul>
        <p><strong>Opsi:</strong> (1) perbaiki dulu — disarankan; (2) terima terbatas dengan waiver T06, tetap KOR-01; (3) tolak jika seluruh KAK dituntut tanpa adendum.</p>""",
    ],
}


def html_page(body: str) -> str:
    return (
        "<!DOCTYPE html><html lang='id'><head><meta charset='utf-8'/>"
        f"<style>{STYLE}</style></head><body>{body}</body></html>"
    )


def convert(html: Path, outdir: Path) -> Path:
    subprocess.run(
        [
            "soffice",
            "--headless",
            "--norestore",
            "--convert-to",
            "pdf:writer_pdf_Export",
            "--outdir",
            str(outdir),
            str(html),
        ],
        check=True,
        capture_output=True,
    )
    return outdir / (html.stem + ".pdf")


def merge(parts: list[Path], dest: Path) -> None:
    cmd = [
        "gs",
        "-dBATCH",
        "-dNOPAUSE",
        "-q",
        "-sDEVICE=pdfwrite",
        f"-sOutputFile={dest}",
        *[str(p) for p in parts],
    ]
    subprocess.run(cmd, check=True)


def main() -> None:
    PDF.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory() as tmp:
        tmp_path = Path(tmp)
        for name, slides in DECKS.items():
            parts = []
            for i, body in enumerate(slides, 1):
                html = tmp_path / f"{name}-{i:02d}.html"
                html.write_text(html_page(body), encoding="utf-8")
                parts.append(convert(html, tmp_path))
            merge(parts, PDF / f"{name}.pdf")
            print(name, "pages", len(parts))


if __name__ == "__main__":
    main()
