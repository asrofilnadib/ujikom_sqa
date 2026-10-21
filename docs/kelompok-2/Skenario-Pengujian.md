# Skenario pengujian kualitas perangkat lunak

**Dokumen:** TP-XYZ-POS-001  
**Acuan:** SQAP-XYZ-POS-001, RTM-XYZ-POS-001, ISO/IEC/IEEE 29119  
**Unit:** J.62SQA00.007.1, **J.62SQA00.008.1** (manual GUI), 009.1, 010.1  
**SUT:** uniCenta oPOS 5.0 + MySQL 8.0 lokal (lab Toko XXX)  
**Tanggal:** 21 Oktober 2026

Lingkungan: Ubuntu 24.04, aplikasi `install/unicenta/opt/unicenta-opos/bin/unicenta-opos`, MySQL lokal `127.0.0.1:3306/unicenta` (user `asrofil`).  
**Bukti screenshot manual:** [docs/bukti/J.62SQA00.008.1-manual/](../bukti/J.62SQA00.008.1-manual/)

## 1. Skenario fungsional (black box)

| ID | KAK | Prasyarat | Langkah | Hasil diharapkan |
| --- | --- | --- | --- | --- |
| TC-F-01 | T01, S01 | Aplikasi terpasang | Buka uniCenta; pastikan bukan workbook Excel | Jendela POS muncul, terhubung DB |
| TC-F-02 | T02 | Produk dummy ada | Catat penjualan 1 Headset Bluetooth XXX tunai | Tiket tersimpan; kasir tidak memakai Excel |
| TC-F-03 | T04 | Stok headset = 20 | Setelah penjualan 1 unit, baca stok | Stok = 19 (real time di DB) |
| TC-F-04 | T05, S02 | Ada pembayaran | Rekap `payments` per bulan | Ada total pemasukan Oktober 2026 |
| TC-F-05 | T06, L02 | Skema lengkap | Cari modul/tabel gaji, payroll, salary | Fungsi hitung gaji karyawan tersedia |
| TC-F-06 | D01 | User default | Periksa peran Administrator vs Employee | Kedua peran ada dan dapat dibedakan |

## 2. Integrasi

| ID | KAK | Langkah | Hasil diharapkan |
| --- | --- | --- | --- |
| TC-I-01 | T03, T05 | Setelah penjualan, kueri `payments` + `tickets` + `receipts` | Baris pembayaran `cash` 150000 terkait tiket lab |
| TC-I-02 | T04 | `stockcurrent` vs `ticketlines` | Unit terjual mengurangi stok lokasi `0` |

## 3. Non-fungsional

| ID | KAK / 25010 | Langkah | Hasil diharapkan |
| --- | --- | --- | --- |
| TC-NF-01 | T02, usability | Operasi kasir tanpa manual khusus Toko XXX | Alur jual dapat ditebak; ada panduan bergambar Bahasa Indonesia |
| TC-NF-02 | L07, portability | Jalankan di Ubuntu client lab | Aplikasi start, JDBC OK |
| TC-ST-01 | T04, performance | Kueri gabungan produk-stok | < 500 ms |
| TC-ST-02 | T04 | BENCHMARK 10.000 baca stok | Selesai tanpa error |

## 4. Keamanan (defensif, lingkungan lokal)

Tidak ada percobaan eksploitasi. Hanya observasi konfigurasi, peran, dan integritas data.

| ID | KAK | Langkah | Hasil diharapkan |
| --- | --- | --- | --- |
| TC-S-01 | D01 | Inventarisasi `roles` | Admin dan karyawan terpisah |
| TC-S-02 | D01, K01 | Cek `people.apppassword` lalu login GUI | Password tidak kosong; login menolak tamu tanpa kredensial |
| TC-S-03 | K01 | Sama dengan S-02 pada data | Tidak ada akun default tanpa kata sandi |
| TC-S-04 | K01 | Cari produk dengan literal SQL ter-escape | Jumlah produk tidak berubah |

## 5. White box

| ID | KAK | Objek | Hasil diharapkan |
| --- | --- | --- | --- |
| TC-W-01 | K01 | `unicentaopos.properties` | Password DB tidak polos |
| TC-W-02 | T06 | `MySQL-create.sql` / daftar tabel | Ada entitas penggajian bila KAK-T06 diimplementasi |
| TC-W-03 | T05 | Laporan `sales_cashflow` dll. | Ada artefak laporan kas/penjualan |

## 6. Deliverable dan proses

| ID | KAK | Objek | Hasil diharapkan |
| --- | --- | --- | --- |
| TC-D-01 | D02, P01–P03 | Paket vendor | Ada dokumentasi kegiatan pembuatan |
| TC-D-02 | D03, D04, A01, A02 | User manual bergambar Toko XXX / quick guide pemilik | Ada, Bahasa Indonesia |
| TC-D-03 | D05, K03 | Klausul garansi 3 bulan | Ada prosedur pemeliharaan |
| TC-P-01 | W01–W03 | Jejak waterfall vendor | Ada bukti gerbang fase |

## 7. Otomatis vs manual

- **Otomatis:** `tests/run_sqa_tests.py` → `docs/kelompok-2/hasil-otomatis.json`
- **Manual / observasi:** peluncuran GUI, tinjauan skema, tinjauan laporan Jasper, tinjauan paket dokumentasi
