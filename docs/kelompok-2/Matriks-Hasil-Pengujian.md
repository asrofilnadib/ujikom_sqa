# Matriks hasil pengujian

**Dokumen:** TR-XYZ-POS-001  
**Pelaksanaan:** 21 Oktober 2026  
**Pelaksana:** Asesi SQA  
**SUT:** uniCenta oPOS 5.0 (Organisasi XYZ) vs KAK Toko XXX  
**Bukti otomatis:** [hasil-otomatis.json](hasil-otomatis.json)  
**Bukti uji manual GUI (J.62SQA00.008.1):** [Bukti-Uji-Manual-GUI.md](Bukti-Uji-Manual-GUI.md) · [folder PNG](../bukti/J.62SQA00.008.1-manual/)  
**Lingkungan:** [CATATAN-INSTALASI.md](../../install/CATATAN-INSTALASI.md)

Ringkasan: **21 kasus** dieksekusi — **12 Pass**, **3 Sebagian**, **6 Fail**. Defect kritis terbuka: akun default tanpa kata sandi. Defect mayor terbuka: tidak ada penggajian; kredensial DB polos; dokumentasi/garansi Toko XXX tidak ada.

## Matriks

| ID | Acuan KAK | Jenis | Langkah (ringkas) | Expected | Actual | Status | Bukti | Keparahan |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| TC-F-01 | T01, S01 | Fungsional, black box | Jalankan `unicenta-opos` | POS desktop menggantikan Excel | Aplikasi native Linux start, konek MySQL (log 21 Okt 11:04) | Pass | [TC-F-01-pos-aktif-katalog-elektronik-toko-xxx.png](../bukti/J.62SQA00.008.1-manual/TC-F-01-pos-aktif-katalog-elektronik-toko-xxx.png); JDBC_OK products=5 | - |
| TC-F-02 | T02 | Fungsional | Simpan penjualan headset tunai | Transaksi tercatat | Tiket `RCPT-LAB-001` + `ticketlines` 1 unit | Pass | [TC-F-02-pencatatan-transaksi-tiket-kasir.png](../bukti/J.62SQA00.008.1-manual/TC-F-02-pencatatan-transaksi-tiket-kasir.png); seed + tabel tickets | - |
| TC-F-03 | T04 | Fungsional | Stok setelah jual | 20 → 19 | `stockcurrent` headset = 19 | Pass | [TC-F-03-stok-produk-xxx.png](../bukti/J.62SQA00.008.1-manual/TC-F-03-stok-produk-xxx.png); TC-F-02 tiket | - |
| TC-F-04 | T05, S02 | Fungsional | Rekap pemasukan bulanan | Ada total bulan | `2026-10 = 150000`; ada laporan `sales_cashflow` | Sebagian | JSON TC-F-04; jrxml cashflow. **Pengeluaran operasional toko tidak otomatis** | Mayor |
| TC-F-05 | T06, L02 | Fungsional | Cari gaji karyawan | Modul/tabel gaji ada | Tidak ada tabel gaji/payroll/salary; hanya shift/leaves/presence | **Fail** | [TC-F-05-skema-tanpa-tabel-gaji.png](../bukti/J.62SQA00.008.1-manual/TC-F-05-skema-tanpa-tabel-gaji.png); JSON TC-F-05 | Mayor |
| TC-F-06 | D01 | Fungsional | Peran karyawan & admin | Keduanya ada | roles Administrator, Manager, Employee, Guest | Pass | JSON TC-S-01; [TC-F-06-form-pelanggan-peran-guest.png](../bukti/J.62SQA00.008.1-manual/TC-F-06-form-pelanggan-peran-guest.png) | - |
| TC-I-01 | T03, T05 | Integrasi | POS ↔ MySQL pembayaran | cash 150000 tersimpan | `cash	150000` | Pass | [TC-I-01-pembayaran-tiket-lab.png](../bukti/J.62SQA00.008.1-manual/TC-I-01-pembayaran-tiket-lab.png); JSON | - |
| TC-I-02 | T04 | Integrasi | ticketlines vs stock | Stok terpotong | 20−1=19 | Pass | JSON TC-A-02 | - |
| TC-A-01 | T03 | Otomatis | SHOW TABLES | Skema POS lengkap | 52 tabel termasuk products, tickets, stockcurrent | Pass | JSON TC-A-01 | - |
| TC-A-02 | T04 | Otomatis | Baca stok | 19 | 19 | Pass | JSON | - |
| TC-ST-01 | T04 | Stress / kinerja | Join produk-stok | < 500 ms | 387.9 ms | Pass | JSON | - |
| TC-ST-02 | T04 | Stress | BENCHMARK 10.000 baca stok | Tanpa error | 125 ms, hasil 0 | Pass | JSON | - |
| TC-NF-01 | T02, A02 | Non-fungsi, usability | Cari quick guide Toko XXX bergambar | Ada, mudah | UI Inggris; tidak ada quick guide pemilik Toko XXX | **Fail** | paket installer, tidak ada manual ID | Mayor |
| TC-NF-02 | L07 | Non-fungsi | Deploy Ubuntu | Jalan di client lab | Diekstrak .deb, binary start | Pass | CATATAN-INSTALASI; sama dengan TC-F-01 (layar kasir) | - |
| TC-S-01 | D01 | Keamanan | Daftar roles | Admin ≠ karyawan | 4 peran termasuk Admin & Employee | Pass | JSON | - |
| TC-S-02 | D01, K01 | Keamanan | Login default | Password wajib | `apppassword` NULL untuk semua user bawaan | **Fail** | [TC-S-02c-query-password-null.png](../bukti/J.62SQA00.008.1-manual/TC-S-02c-query-password-null.png); JSON | Kritis |
| TC-S-03 | K01 | Keamanan | Akun default | Tidak NULL | Empat akun password NULL | **Fail** | sama TC-S-02c | Kritis |
| TC-S-04 | K01 | Keamanan | Cari produk ter-escape | Tabel utuh | 5 produk tetap | Pass | JSON | - |
| TC-W-01 | K01 | White box | Baca properties | Password tidak polos | `db.password` tersimpan polos di properties | **Fail** | [TC-W-01-db-password-properties.png](../bukti/J.62SQA00.008.1-manual/TC-W-01-db-password-properties.png) | Mayor |
| TC-W-02 | T06 | White box | Skema vs KAK-T06 | Entitas gaji | Tidak ada | **Fail** | MySQL-create.sql | Mayor |
| TC-W-03 | T05 | White box | Artefak laporan | Ada laporan penjualan/kas | Ada `sales_cashflow`, `sales_payments`, `inventory` | Pass | folder reports | - |
| TC-D-01 | D02, P01–P03 | Deliverable | Dokumen kegiatan pembuatan | Ada | Tidak menyertai paket 5.0 | **Fail** | isi paket | Mayor |
| TC-D-02 | D03, D04, A01, A02 | Deliverable | User manual bergambar | Ada | Tidak ada untuk Toko XXX | **Fail** | isi paket | Mayor |
| TC-D-03 | D05, K03 | Proses | Garansi 3 bulan | Ada kanal & SLA | Tidak ada di paket | **Fail** | isi paket | Mayor |
| TC-P-01 | W01–W03 | Proses | Jejak waterfall | Ada gerbang fase | Tidak terbukti dari artefak vendor | Sebagian | VR-XYZ-POS-001 | Mayor |

Catatan: baris TC-S-02 dan TC-S-03 adalah defect yang sama (akun tanpa password); dihitung sekali pada ringkasan defect.

## Defect log

| Defect | Sumber | Keparahan | Status | KAK |
| --- | --- | --- | --- | --- |
| DEF-01 | Tidak ada modul penggajian | Mayor | Terbuka | T06, L02 |
| DEF-02 | Password default NULL | Kritis | Terbuka | K01, D01 |
| DEF-03 | Kredensial DB polos di properties | Mayor | Terbuka | K01 |
| DEF-04 | Laporan pengeluaran toko tidak otomatis lengkap | Mayor | Terbuka | T05, S02 |
| DEF-05 | Tidak ada user manual/quick guide Toko XXX | Mayor | Terbuka | D03, D04, A01, A02 |
| DEF-06 | Garansi 3 bulan tidak terbukti | Mayor | Terbuka | D05, K03 |
| DEF-07 | Jejak waterfall/laporan P01–P03 tidak ada | Mayor | Terbuka | W, P |

## Keputusan gerbang Verification (SQAP 6.5)

**Tidak lulus rilis** ke Toko XXX: ada defect kritis (DEF-02) dan fungsi wajib KAK-T06 gagal (DEF-01).
