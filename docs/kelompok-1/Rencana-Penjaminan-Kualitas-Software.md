# Rencana Penjaminan Kualitas Software

**Proyek:** Sistem Kasir Point of Sales — Toko XXX  
**Organisasi pengembang:** Organisasi XYZ  
**Perangkat lunak yang dijamin:** uniCenta oPOS (kandidat implementasi POS)  
**Dokumen:** SQAP-XYZ-POS-001  
**Versi:** 1.0  
**Tanggal:** 21 Oktober 2026  
**Penyusun:** Asesi Software Quality Assurance  
**Acuan asesmen:** SS-LSP.UEU-002-2020 — unit J.625QA00.001.1 s.d. 006.1  
**Bahan:** Kerangka Acuan Kerja Sistem Kasir Point of Sales  

---

## 1. Tujuan dokumen

Dokumen ini adalah Rencana Penjaminan Kualitas (Software Quality Assurance Plan) untuk proyek POS Toko XXX. Rencana dipakai sebagai acuan:

- menentukan metodologi dan standar mutu;
- membatasi ruang lingkup mutu produk dan proses;
- mengintegrasikan fungsi SQA ke organisasi XYZ;
- merencanakan pelaksanaan, sumber daya, mitigasi risiko, dan pemeliharaan perubahan.

Pengujian pada tahap Development (Kelompok 2) **wajib mengacu** ke rencana ini.

---

## 2. Metodologi dan kerangka kerja (J.625QA00.001.1)

### 2.1 Posisi SQA terhadap KAK

KAK menetapkan metodologi pengembangan **Waterfall** (Requirements → Design → Implementation → Verification → Maintenance), dengan sifat linear, fase tidak tumpang tindih, dan rencana tidak berubah setelah fase selesai. SQA **tidak mengganti** waterfall itu, melainkan menempelkan gerbang mutu (quality gate) di setiap akhir fase.

### 2.2 Kerangka yang dipakai

| Lapisan | Standar | Alasan dipilih |
| --- | --- | --- |
| Rencana SQA | IEEE 730-2014 *Software Quality Assurance Processes* | Struktur SQAP: lingkup, tanggung jawab, aktivitas, catatan, standar. |
| Siklus hidup | ISO/IEC 12207:2017 | Memetakan aktivitas waterfall KAK ke proses yang dapat diaudit. |
| Model mutu produk | ISO/IEC 25010:2011 | Karakteristik: functional suitability, performance efficiency, compatibility, usability, reliability, security, maintainability, portability. |
| Proses pengujian | ISO/IEC/IEEE 29119 | Test plan, test case, test procedure, test completion report, matriks ketertelusuran. |
| Teknik uji | Black box, white box, integrasi, stress, keamanan | Diminta instruksi terstruktur Kelompok 2. |
| Informasi & kerahasiaan | Prinsip ISO/IEC 27001 (kendali akses, kerahasiaan) | KAK-K01: data rahasia perusahaan tidak disebar. |

Tidak semua klausul standar diadopsi penuh (anggaran Rp 25.000.000 dan 45 hari kerja). Yang diadopsi adalah **subset yang dapat dibuktikan** pada proyek ini.

### 2.3 Prinsip pelaksanaan

1. **Independensi SQA.** SQA tidak merangkap programmer. Temuan dilaporkan ke Project Manager, bukan disembunyikan di tim coding.
2. **Ketertelusuran.** Setiap kebutuhan KAK punya ID (`KAK-Txx`, `KAK-Sxx`, `KAK-Dxx`) yang muncul lagi di kasus uji dan matriks hasil.
3. **Gerbang fase.** Fase berikutnya tidak dimulai sebelum exit criteria fase berjalan berstatus lulus atau *accepted with waiver* tertulis.
4. **Bukti, bukan opini.** Status Pass/Fail hanya boleh diisi setelah ada observasi (screenshot, log, hasil kueri, atau catatan uji).

### 2.4 Teknik pengujian yang direncanakan

| Teknik | Objek | Kapan |
| --- | --- | --- |
| Black box | Fungsi kasir, stok, laporan, peran pengguna | Verification |
| White box | Konfigurasi, skema DB, kendali akses di kode/konfig | Verification |
| Integrasi | Aplikasi desktop ↔ MySQL | Implementation akhir & Verification |
| Stress | Banyak transaksi / kueri stok beruntun | Verification |
| Fungsional | KAK-T01 s.d. KAK-T06, KAK-S01–S02 | Verification |
| Non-fungsional | Kinerja, kebergunaan, keandalan, keamanan (ISO 25010) | Verification |
| Manual | Alur karyawan dan admin di GUI | Verification |
| Otomatis | Integritas data, koneksi DB, regresi kueri | Verification & Maintenance |
| Keamanan | Autentikasi, otorisasi peran, kerahasiaan kredensial, input tidak wajar | Verification |

---

## 3. Ruang lingkup penjaminan kualitas produk (J.625QA00.002.1)

### 3.1 Termasuk dalam lingkup

Produk: aplikasi POS desktop + basis data untuk Toko XXX, dioperasikan karyawan dan admin (KAK-D01).

| Karakteristik ISO 25010 | Kebutuhan KAK yang dicakup | Kriteria lulus (ringkas) |
| --- | --- | --- |
| Functional suitability | KAK-T01–T06, KAK-S01–S02 | Semua fungsi wajib ada dan menghasilkan data benar. |
| Reliability | KAK-T03, KAK-K03 | Transaksi tersimpan di DB; aplikasi dapat dibuka ulang tanpa hilang data. |
| Usability | KAK-T02, KAK-A02, KAK-D04 | Kasir dapat mencatat transaksi tanpa Excel; ada panduan bergambar. |
| Performance efficiency | KAK-T04 | Stok terlihat sesuai transaksi terakhir (real time operasional). |
| Security | KAK-K01, KAK-D01 | Login, pemisahan peran karyawan/admin, data tidak diekspos di berkas polos tanpa kendali. |
| Maintainability | KAK-D05, KAK-K03 | Perubahan dalam garansi 3 bulan dapat diuji regresi. |
| Portability / compatibility | KAK-L07 | Dapat dipasang di komputer client (Ubuntu/Windows sesuai serah terima). |

### 3.2 Fungsi wajib vs penunjang

**Wajib (harus Pass agar produk “sesuai KAK”):**

- Ganti pencatatan Excel dengan POS (KAK-T01, KAK-S01).
- Catat transaksi barang ke database (KAK-T02, KAK-T03).
- Stok barang real time (KAK-T04).
- Laporan pemasukan dan pengeluaran otomatis, termasuk rekap bulanan (KAK-T05, KAK-S02).
- Perhitungan gaji setiap karyawan (KAK-T06, KAK-L02).
- Dua peran operasi: karyawan dan admin (KAK-D01).

**Penunjang (tidak menolak serah terima bila kurang, tetapi dicatat):**

- Integrasi toko daring, pemesanan meja restoran, hardware printer/barcode — tidak disebut KAK.

### 3.3 Di luar lingkup produk

- Pengembangan ulang POS dari nol (asesmen memakai perangkat lunak Organisasi XYZ).
- Infrastruktur jaringan toko, mesin kasir fisik, dan data produksi riil pelanggan.
- Sertifikasi ISO organisasi XYZ secara formal.

---

## 4. Ruang lingkup penjaminan kualitas proses (J.625QA00.003.1)

SQA menjamin **cara membangun**, bukan hanya hasil jadi.

| Fase waterfall | Aktivitas SQA | Exit criteria |
| --- | --- | --- |
| Requirements | Review KAK vs daftar kebutuhan ber-ID; cek kelengkapan (gaji, stok, laporan). | Daftar kebutuhan disetujui PM; tidak ada kebutuhan wajib tanpa ID. |
| Design | Review arsitektur desktop+DB, desain UI, pemisahan peran. | Desain menelusuri setiap KAK-T; gap tercatat. |
| Implementation | Review kode/konfigurasi seperlunya; cek skema DB; larangan data rahasia di repositori publik. | Build terpasang di lingkungan uji; kredensial bukan milik produksi. |
| Verification | Pelaksanaan uji sesuai ISO 29119: skenario, matriks, defect. | Semua kasus wajib dieksekusi; defect kritis ditutup atau waiver. |
| Maintenance | Uji regresi perubahan; pantau garansi 3 bulan. | Setiap perubahan punya impact analysis dan hasil regresi. |

Kesesuaian terhadap aturan KAK-W01–W03: SQA menolak memulai Design jika Requirements belum ditandatangani, dan menolak Implementation jika Design belum lulus gerbang.

---

## 5. Integrasi SQA ke organisasi pengembang (J.625QA00.006.1)

### 5.1 Struktur

KAK hanya menyebut Project Manager, System Designer, dan Programmer. Fungsi SQA ditambahkan sebagai peran **independen** di bawah PM, setara Designer untuk keputusan “lulus gerbang”.

### 5.2 Matriks RACI

R = Responsible, A = Accountable, C = Consulted, I = Informed

| Aktivitas | PM | Designer | Programmer | SQA | Pemilik Toko XXX |
| --- | --- | --- | --- | --- | --- |
| Baseline kebutuhan KAK | A | C | I | R | C |
| Arsitektur & UI | A | R | C | C | I |
| Konstruksi aplikasi | A | C | R | I | I |
| Rencana & kasus uji | A | C | C | R | I |
| Eksekusi uji | I | C | C | R | I |
| Keputusan rilis / serah terima | A | C | I | C | R |
| Pelatihan pengguna | A | R | I | C | C |
| Garansi 3 bulan | A | C | R | C | I |
| Kerahasiaan data (KAK-K01) | A | I | R | C | I |

### 5.3 Titik integrasi kerja harian

1. **Review dokumen** di akhir tiap fase (daftar hadir + daftar temuan).
2. **Definition of Done** rilis: seluruh KAK-T wajib Pass atau waiver tertulis dari pemilik.
3. **Defect triage** harian pada fase Verification: PM memutus prioritas, Programmer memperbaiki, SQA verifikasi ulang.
4. **Laporan** mengikuti KAK-P01–P03: pendahuluan, mingguan, akhir — SQA menyumbang status gerbang dan metrik cacat.

---

## 6. Rencana pelaksanaan penjaminan kualitas (J.625QA00.001.1 / 003.1)

### 6.1 Batasan proyek

- Durasi pengembangan: **45 hari kerja**.
- Anggaran: **Rp 25.000.000,-**
- Garansi: **3 bulan** setelah serah terima.
- Lingkungan uji asesmen: Ubuntu, Java, MySQL, uniCenta oPOS.

### 6.2 Jadwal gerbang (45 hari kerja)

Asumsi 5 hari kerja/minggu ≈ 9 minggu.

| Minggu | Fase | Aktivitas SQA | Keluaran |
| --- | --- | --- | --- |
| 1 | Requirements | Review KAK, ID kebutuhan, risiko awal | SQAP v1.0, RTM awal, laporan pendahuluan (KAK-P01) |
| 2–3 | Design | Review arsitektur, UI, model data, peran | Berita acara review desain |
| 4–6 | Implementation | Inspeksi build, skema DB, kerahasiaan kredensial | Build terpasang di lab |
| 7–8 | Verification | Uji manual, otomatis, integrasi, stress, keamanan | Skenario, matriks hasil, defect log |
| 9 | Verification tutup + serah terima | Uji penerimaan pemilik, cek deliverable KAK-D | Laporan akhir, user manual, berita acara |
| +3 bulan | Maintenance | Regresi, tiket garansi | Catatan pemeliharaan |

Laporan mingguan (KAK-P02) terbit setiap Jumat.

### 6.3 Strategi tingkat uji

| Tingkat | Objek | Penanggung jawab |
| --- | --- | --- |
| Unit / komponen | Logika stok, total transaksi (bila kode tersedia) | Programmer + tinjauan SQA |
| Integrasi | GUI POS ↔ JDBC ↔ MySQL | SQA |
| Sistem | Alur kasir end-to-end | SQA |
| Penerimaan | Skenario pemilik Toko XXX | SQA fasilitasi, pemilik memutuskan |

### 6.4 Kriteria masuk Verification

- Aplikasi terpasang dan dapat login di lingkungan uji.
- Basis data uji terpisah dari produksi.
- Data dummy Toko XXX tersedia (kategori, produk, stok, pengguna).
- SQAP dan skenario uji disetujui PM.

### 6.5 Kriteria lulus rilis (Definition of Done)

- 100% kasus uji wajib (KAK-T01–T06, KAK-S01–S02, KAK-D01) dieksekusi.
- 0 defect **Kritis** terbuka (kehilangan data, stok salah, tidak bisa login admin).
- Defect Mayor punya rencana perbaikan dalam garansi atau waiver pemilik.
- Deliverable KAK-D02–D05 tersedia.
- User manual bergambar dan quick guide pemilik ada (KAK-A01, KAK-A02, KAK-D04).

---

## 7. Rencana mitigasi risiko (J.625QA00.004.1)

Skala dampak dan probabilitas: 1 rendah – 3 tinggi. Skor = D × P. Perlakuan: hindari, kurangi, alihkan, terima.

| ID | Risiko | D | P | Skor | Pemicu | Mitigasi (preventif) | Kontingensi (korektif) |
| --- | --- | --- | --- | --- | --- | --- | --- |
| R01 | Fungsi penggajian (KAK-T06) tidak ada di produk | 3 | 3 | 9 | KAK menyebut analisis penggajian, POS generik sering tidak punya payroll | Review Requirements vs fitur produk sebelum Design ditutup | Tambah modul gaji atau integrasi aplikasi penggajian; waiver tertulis jika ditunda |
| R02 | Stok tidak real time (KAK-T04) | 3 | 2 | 6 | Transaksi tidak memotong stok; cache | Kasus uji stok wajib; cek DB setelah penjualan | Perbaiki trigger/alur inventory; hentikan rilis jika stok salah |
| R03 | Laporan pemasukan/pengeluaran tidak otomatis / tidak bulanan (KAK-T05, KAK-S02) | 3 | 2 | 6 | Modul laporan tidak dikonfigurasi | Inventarisasi laporan di Design | Buat/atur laporan; ekspor berkala |
| R04 | Kebocoran data rahasia (KAK-K01) | 3 | 2 | 6 | Password default, kredensial di berkas polos, role terlalu luas | Uji keamanan; larangan commit secret; ganti default password | Rotasi password, batasi role, audit akses |
| R05 | Waterfall kaku vs permintaan perubahan (KAK-W03 vs kenyataan toko) | 2 | 3 | 6 | Pemilik menambah kebutuhan di tengah jalan | CCB (pasal 8); freeze lingkup setelah Requirements | Impact analysis + adendum KAK |
| R06 | Anggaran Rp 25 juta tidak cukup untuk seluruh wajib KAK | 2 | 2 | 4 | Payroll + dokumentasi + garansi | MoSCoW: wajib vs penunjang | Pangkas penunjang, bukan fungsi wajib |
| R07 | Jadwal 45 hari terlewati karena gerbang gagal | 2 | 2 | 4 | Cacat di Verification minggu 7–8 | Uji dini integrasi di minggu 6 | Lembur terkontrol / geser fitur penunjang |
| R08 | Deliverable dokumentasi/gambar tidak ada (KAK-D02–D04) | 2 | 2 | 4 | Tim hanya fokus coding | Template manual di fase Design | Tulis manual dari screenshot uji |
| R09 | Lingkungan uji tidak mewakili client (KAK-L07) | 2 | 2 | 4 | Beda OS/JVM/DB | Catat matriks lingkungan | Uji ulang di OS target sebelum serah terima |
| R10 | Garansi 3 bulan tidak operasional (KAK-K03, KAK-D05) | 2 | 1 | 2 | Tidak ada kanal tiket | SLA garansi di kontrak serah terima | Aktifkan kanal email/tiket + regresi |

Risiko prioritas (skor ≥ 6) dilaporkan ke PM setiap laporan mingguan.

---

## 8. Rencana pemeliharaan terkait permintaan perubahan

Berlaku pada fase Maintenance dan bila ada usulan perubahan sebelum rilis.

### 8.1 Change Control Board (CCB)

Anggota: PM (ketua), System Designer, SQA, perwakilan pemilik Toko XXX. Programmer hadir sebagai consulted.

### 8.2 Alur perubahan

1. Pemohon mengisi tiket: deskripsi, alasan, kebutuhan KAK yang terpengaruh.
2. SQA + Designer melakukan **impact analysis**: fungsi, data, uji regresi, jadwal, biaya.
3. CCB memutuskan: tolak / terima ke baseline / tunda ke garansi.
4. Jika diterima: adendum KAK, update RTM, update kasus uji.
5. Programmer mengerjakan; SQA uji regresi himpunan kasus terkait + smoke test kasir.
6. Rilis patch berversi (contoh 1.0.1); catatan di log pemeliharaan.

### 8.3 Klasifikasi

| Jenis | Contoh | Target |
| --- | --- | --- |
| Defect garansi | Stok tidak terpotong | Perbaikan dalam 5 hari kerja |
| Perubahan kecil | Tambah kategori barang | Masuk sprint pemeliharaan, regresi terbatas |
| Perubahan besar | Modul gaji baru | Adendum + jadwal baru, bukan “selip diam-diam” |

Bertentangan dengan KAK-W03: rencana fase yang sudah ditutup **tidak diubah isinya**, tetapi perubahan dicatat sebagai **baseline baru** agar jejak tetap linear dan dapat diaudit.

### 8.4 Jendela garansi 3 bulan

- Kanal: tiket tertulis ke PM Organisasi XYZ.
- SQA memastikan setiap patch punya bukti uji sebelum masuk komputer client.
- Setelah 3 bulan, pemeliharaan berlanjut hanya dengan kontrak baru.

---

## 9. Sumber daya yang dibutuhkan (J.625QA00.005.1)

### 9.1 Manusia

| Peran | Jumlah | Porsi SQA |
| --- | --- | --- |
| Project Manager | 1 | Akuntabel gerbang |
| System Designer | 1 | Review desain, pelatihan |
| Programmer | 1 | Perbaikan defect |
| SQA | 1 | Rencana, uji, rekomendasi |
| Pemilik / admin Toko XXX | 1 | UAT, keputusan rilis |

### 9.2 Perangkat dan lingkungan uji

| Item | Spesifikasi rencana |
| --- | --- |
| Komputer uji | Ubuntu 24.04 LTS, 64-bit |
| Runtime | Java sesuai installer uniCenta (lab: OpenJDK 8 tersedia) |
| Basis data | MySQL 8 / MariaDB, skema khusus uji `unicentaopos` |
| Aplikasi | uniCenta oPOS Linux 64-bit dari unicenta.com/downloads/installers/ |
| Data uji | Produk elektronik dummy Toko XXX, user admin dan kasir |
| Alat uji | Checklist manual, skrip SQL/Python integritas data, klien MySQL |
| Dokumentasi | Template SQAP, skenario, matriks, user manual bergambar |

### 9.3 Waktu

| Kegiatan SQA | Alokasi (hari kerja, di dalam 45 hari) |
| --- | --- |
| SQAP + review kebutuhan | 3 |
| Review desain | 4 |
| Persiapan lingkungan & data | 2 |
| Eksekusi uji + defect | 8 |
| Dokumentasi hasil + UAT | 3 |
| Siaga garansi (setelah rilis) | 3 bulan kalender, on-call |

### 9.4 Data dan kerahasiaan

- Hanya data dummy. Tidak memakai data pelanggan nyata Toko XXX.
- Password lingkungan uji beda dari produksi.
- Berkas konfigurasi yang berisi kredensial tidak dibagikan di luar tim.

---

## 10. Catatan dan metrik

SQA memelihara:

- Requirements Traceability Matrix (kebutuhan → desain → kasus uji → hasil).
- Defect log: ID, keparahan, status, tautan KAK.
- Metrik: % kasus dieksekusi, % Pass, jumlah defect terbuka per keparahan, jumlah perubahan CCB.

Keparahan defect:

| Tingkat | Definisi |
| --- | --- |
| Kritis | Data hilang/salah stok; tidak bisa beroperasi; lubang akses admin |
| Mayor | Fungsi wajib KAK gagal (laporan, gaji, peran) tetapi ada workaround lemah |
| Minor | UI, teks, kenyamanan |
| Info | Saran, di luar KAK |

---

## 11. Referensi

1. Kerangka Acuan Kerja Sistem Kasir Point of Sales — Toko XXX.
2. IEEE Std 730-2014, Software Quality Assurance Processes.
3. ISO/IEC 25010:2011, System and software quality models.
4. ISO/IEC 12207:2017, Software life cycle processes.
5. ISO/IEC/IEEE 29119, Software testing.
6. Instruksi terstruktur 4A skema SS-LSP.UEU-002-2020.

---

**Persetujuan (asesmen):** dokumen ini menjadi acuan Kelompok 2 dan Kelompok 3. Perubahan hanya melalui pasal 8.
