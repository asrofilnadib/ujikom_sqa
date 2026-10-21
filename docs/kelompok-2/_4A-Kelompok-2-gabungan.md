# 4A — Kelompok 2: SQA Development

**Proyek:** Sistem Kasir POS Toko XXX · **SUT:** uniCenta oPOS 5.0

**Tanggal:** 21 Oktober 2026


---

# Verifikasi tahap pengembangan perangkat lunak

**Dokumen:** VR-XYZ-POS-001  
**Acuan:** SQAP-XYZ-POS-001 pasal 4, KAK-W01–W03, KAK-L01–L07  
**Unit kompetensi:** J.625QA00.007.1  
**Perangkat lunak:** uniCenta oPOS (Organisasi XYZ) untuk Toko XXX  
**Tanggal observasi:** 21 Oktober 2026

## 1. Metode verifikasi

uniCenta oPOS adalah produk jadi. SQA **tidak mengarang** riwayat sprint internal vendor. Verifikasi dilakukan dengan membandingkan **bukti yang tampak pada artefak dan produk** terhadap fase waterfall di KAK.

Status: **Sesuai** / **Sebagian** / **Tidak terbukti** / **Tidak sesuai**.

## 2. Hasil gerbang fase

| Fase KAK | Bukti yang dicari | Bukti yang ditemukan | Status |
| --- | --- | --- | --- |
| Requirements | Kebutuhan user/sistem terdokumentasi (KAK-L01, KAK-L02 termasuk penggajian) | KAK Toko XXX ada. Daftar kebutuhan ber-ID disusun SQA (RTM). Analisis penggajian ada di KAK, **tidak** terlihat sebagai modul di produk. | Sebagian |
| Design | Arsitektur desktop + DB, desain UI (KAK-L03, KAK-L04) | Arsitektur client Java + JDBC + MySQL/MariaDB terbukti dari installer dan konfigurasi. UI kasir, stok, laporan, admin tersedia. Tidak ada desain UI penggajian. | Sebagian |
| Implementation | Program terpasang, skema DB, peran pengguna (KAK-D01) | Aplikasi terpasang di Ubuntu; skema DB terbentuk saat konfigurasi; peran Admin/Manager/Employee ada. | Sesuai (produk inti) |
| Verification | Testing aplikasi (KAK-L05) | Dilaksanakan SQA: manual, otomatis, integrasi, stress, keamanan — lihat skenario dan matriks. | Sesuai (aktivitas asesmen) |
| Maintenance | Garansi 3 bulan, dokumentasi, deploy client (KAK-L06, KAK-L07, KAK-D05) | Lingkungan client lab ada. User manual vendor berbahasa Inggris, bukan quick guide bergambar Toko XXX. Prosedur garansi 3 bulan tidak menyertai paket. | Tidak sesuai / tidak terbukti |

## 3. Kesesuaian aturan waterfall

| Aturan | Observasi |
| --- | --- |
| KAK-W01 Linear flow | Organisasi XYZ menyerahkan produk jadi; jejak fase sequential **tidak** dilampirkan (tidak ada laporan pendahuluan/mingguan/akhir vendor). |
| KAK-W02 Phases do not overlap | Tidak dapat diverifikasi dari artefak produk. |
| KAK-W03 Plans never change | Tidak ada log CCB dari vendor. SQA menerapkan CCB sendiri untuk temuan asesmen. |

**Kesimpulan gerbang proses:** produk dapat diuji, tetapi **bukti disiplin waterfall Organisasi XYZ tidak lengkap**. Ini temuan proses, bukan gagal instalasi.

## 4. Keputusan masuk uji sistem

Kriteria masuk SQAP pasal 6.4:

- [x] Aplikasi dapat dijalankan di lingkungan uji
- [x] Basis data uji terpisah (bukan data produksi toko)
- [x] SQAP dan skenario siap
- [x] Data dummy dapat dibuat

Verification **boleh dilanjutkan**. Gap penggajian dan dokumentasi Toko XXX dicatat sebagai defect, tidak ditutup diam-diam.

---

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

---

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

---

# Lampiran — Bukti uji manual GUI (J.62SQA00.008.1)

**Unit:** J.62SQA00.008.1 — *Melakukan pengujian kualitas perangkat lunak secara manual*  
**SUT:** uniCenta oPOS 5.0 · skema `unicenta` · data **Elektronik Toko XXX**  
**Tanggal:** 21 Oktober 2026  

Proses: setiap kasus = langkah di GUI → bandingkan Expected/Actual → simpan bukti visual. File PNG: [`../bukti/J.62SQA00.008.1-manual/`](../bukti/J.62SQA00.008.1-manual/).

---

## 1. TC-F-01 · POS aktif menggantikan Excel (KAK T01, S01)

| Langkah manual | Field / area yang dicek |
| --- | --- |
| Jalankan `unicenta-opos`, login **Administrator** (password kosong — temuan terpisah TC-S-02) | Dialog login: pilih role, field password |
| Pastikan layar **Sales** terbuka | Grid tiket, keypad, kategori produk |
| Pilih kategori **Elektronik Toko XXX** | Panel kategori kiri bawah |
| Pastikan produk dummy XXX tampil | Tombol Headset, Keyboard, Mouse, Monitor, Kabel HDMI |

**Expected:** Aplikasi desktop POS siap transaksi, bukan Excel.  
**Actual:** Pass — katalog Toko XXX dan peran Administrator terlihat.

![TC-F-01 layar kasir](../bukti/J.62SQA00.008.1-manual/TC-F-01-pos-aktif-katalog-elektronik-toko-xxx.png)

---

## 2. TC-F-02 · Pencatatan transaksi di tiket (KAK T02, T03)

| Langkah manual | Field / area yang dicek |
| --- | --- |
| Klik produk (mis. Headset + Keyboard) | Baris **Item, Price, Units, Taxes, Value** terisi |
| Verifikasi **Subtotal, Tax, Total** | Field ringkasan kanan bawah grid |
| (Opsional) Bayar tunai sampai tiket selesai | Dialog payment: metode **cash**, nominal **tendered** |

**Expected:** Transaksi tercatat di antarmuka tanpa Excel.  
**Actual:** Pass — multi-item di tiket, pajak 20% terhitung.

![TC-F-02 tiket penjualan](../bukti/J.62SQA00.008.1-manual/TC-F-02-pencatatan-transaksi-tiket-kasir.png)

**Integrasi DB (pelengkap TC-I-01):**

![TC-I-01 query pembayaran tiket lab](../bukti/J.62SQA00.008.1-manual/TC-I-01-pembayaran-tiket-lab.png)

---

## 3. TC-F-03 · Stok real time (KAK T04)

| Langkah manual | Field / area yang dicek |
| --- | --- |
| Catat stok lewat DB **sebelum** jual | Kolom `units` per produk XXX |
| Jual 1 unit lewat GUI | Tiket menampilkan produk terjual |
| Jalankan ulang query stok | `units` turun 1 |

**Expected:** Stok berkurang sesuai penjualan.  
**Actual:** Pass — contoh lab headset 20→19; snapshot stok terkini di bawah.

![TC-F-03 stok produk XXX](../bukti/J.62SQA00.008.1-manual/TC-F-03-stok-produk-xxx.png)

---

## 4. TC-F-05 · Modul gaji (KAK T06) — Fail

| Langkah manual | Field / area yang dicek |
| --- | --- |
| Menu utama → cari **Payroll / Salary / Gaji** | Entri menu backoffice |
| Jika tidak ada, cek skema DB | Tabel `payroll`, `salary`, `gaji` |

**Expected:** Fitur hitung gaji karyawan.  
**Actual:** **Fail** — tidak ada modul; skema tanpa tabel gaji (DEF-01).

![TC-F-05 skema tanpa tabel gaji](../bukti/J.62SQA00.008.1-manual/TC-F-05-skema-tanpa-tabel-gaji.png)

---

## 5. TC-F-06 · Peran & data pelanggan (KAK D01)

| Langkah manual | Field / area yang dicek |
| --- | --- |
| Ikon **Customer** di toolbar | Form: **Search Key***, **Name***, Tax Category, telepon, email |
| Isi field wajib (contoh lab) | Search key `ASROFIL`, nama dummy |
| Bandingkan sesi **Administrator** vs **Guest** | Footer kiri: teks role pengguna |

**Expected:** Peran admin/karyawan dapat dibedakan; data pelanggan dapat diinput.  
**Actual:** Pass sebagian peran (4 role di DB); form pelanggan berfungsi; password default tetap temuan TC-S-02.

![TC-F-06 form pelanggan — field nama terisi](../bukti/J.62SQA00.008.1-manual/TC-F-06a-form-pelanggan-field-nama-terisi.png)

![TC-F-06 sesi Guest](../bukti/J.62SQA00.008.1-manual/TC-F-06-form-pelanggan-peran-guest.png)

---

## 6. TC-S-02 / TC-S-03 · Password default kosong (KAK K01) — Fail kritis

| Langkah manual | Field / area yang dicek |
| --- | --- |
| Logout → login **Administrator** | Field **password** dikosongkan → tetap masuk |
| Query `people.apppassword` | Semua baris `password_null = 1` |

**Expected:** Password wajib, tidak NULL.  
**Actual:** **Fail kritis** (DEF-02).

![TC-S-02 query password NULL](../bukti/J.62SQA00.008.1-manual/TC-S-02c-query-password-null.png)

---

## 7. TC-W-01 · Kredensial DB di berkas konfigurasi (KAK K01) — Fail

| Langkah manual | Field / area yang dicek |
| --- | --- |
| Buka `~/unicentaopos.properties` | Baris `db.password=`, `db.user=`, `db.schema=` |

**Expected:** Rahasia tidak disimpan polos.  
**Actual:** **Fail** — password DB terbaca polos (DEF-03).

![TC-W-01 properties](../bukti/J.62SQA00.008.1-manual/TC-W-01-db-password-properties.png)

---

## Regenerasi bukti

```bash
~/Project/personal/ujikom_sqa/install/scripts/render-terminal-bukti.sh
# Screenshot GUI: saat uniCenta fokus, pakai Flameshot / Shutter ke folder bukti dengan nama TC-*.png
```
