# Rekomendasi penjaminan kualitas perangkat lunak

**Dokumen:** REC-XYZ-POS-001  
**Unit:** J.625QA00.011.1, J.625QA00.012.1  
**Stakeholder:** Pemilik Toko XXX, Project Manager Organisasi XYZ  
**Acuan:** KAK, SQAP-XYZ-POS-001, TR-XYZ-POS-001  
**Tanggal:** 21 Oktober 2026

## 1. Evaluasi pelaksanaan SQA

SQA merencanakan mutu sebelum uji (Kelompok 1), lalu menguji produk jadi uniCenta oPOS 5.0 terhadap KAK. Pendekatan ini sesuai instruksi 4A: rencana dulu, uji mengacu rencana.

Yang berjalan baik:

- Ketertelusuran ID KAK → kasus uji → hasil.
- Integrasi POS ↔ MySQL terbukti (transaksi, stok, pembayaran).
- Stok bergerak sesuai penjualan lab (20 → 19).
- Ada pemisahan peran admin/karyawan di skema.
- Kinerja kueri stok di lab memadai.

Yang tidak memadai:

- Gerbang rilis SQAP **gagal**: defect kritis terbuka dan fungsi wajib gaji tidak ada.
- Bukti proses waterfall vendor tidak dilampirkan.
- Deliverable dokumentasi dan garansi 3 bulan tidak ada.

## 2. Kesesuaian KAK vs hasil uji

| ID KAK | Pernyataan | Hasil | Catatan |
| --- | --- | --- | --- |
| T01, S01 | Ganti Excel dengan POS | Sesuai | Aplikasi desktop berjalan |
| T02 | Pencatatan transaksi mudah | Sesuai sebagian | Bisa dicatat; tanpa panduan ID |
| T03 | Tersimpan di database | Sesuai | 52 tabel, tiket lab ada |
| T04 | Stok real time | Sesuai | Stok terpotong di `stockcurrent` |
| T05, S02 | Laporan pemasukan & pengeluaran otomatis / bulanan | Sesuai sebagian | Pemasukan dapat direkap; pengeluaran operasional tidak lengkap |
| T06, L02 | Hitung gaji setiap karyawan | **Tidak sesuai** | Tidak ada modul/tabel gaji |
| D01 | Karyawan dan admin | Sesuai sebagian | Peran ada, tetapi password kosong |
| D02–D04, A01–A02 | Dokumentasi & manual bergambar | **Tidak sesuai** | Tidak ada untuk Toko XXX |
| D05, K03 | Garansi 3 bulan | **Tidak sesuai** | Tidak terbukti |
| K01 | Kerahasiaan data | **Tidak sesuai** | Password NULL; DB password polos |
| W01–W03, P01–P03 | Waterfall & pelaporan | Tidak terbukti | Produk jadi tanpa jejak fase |
| L07 | Deploy client | Sesuai (lab Ubuntu) | Native .deb diekstrak |

**Ketercapaian fungsi wajib:** 3/6 penuh (T01, T03, T04); T02 dan T05 sebagian; **T06 nol**.

## 3. Rekomendasi korektif (perbaiki produk sekarang)

| ID | Tindakan | Pemilik | Prioritas | Jika tidak dilakukan |
| --- | --- | --- | --- | --- |
| KOR-01 | Wajibkan password saat buat user; set password kuat untuk Administrator/Manager/Employee; nonaktifkan Guest di toko | Programmer + SQA | Kritis, sebelum UAT | Siapa saja di kasir dapat masuk sebagai admin; stok dan harga dapat diubah; bertentangan KAK-K01 |
| KOR-02 | Bangun modul penggajian (gaji pokok, presensi `leaves`/`shifts` yang sudah ada, slip gaji) atau integrasikan aplikasi payroll terpisah; update RTM | PM + Designer + Programmer | Mayor, adendum KAK bila ditunda | Toko tetap hitung gaji di Excel; tujuan KAK-T06 gagal; serah terima dapat ditolak pemilik |
| KOR-03 | Enkripsi atau simpan kredensial DB di vault/OS secret; jangan tulis password polos di `unicentaopos.properties` | Programmer | Mayor | File home user membocorkan akses penuh ke database toko |
| KOR-04 | Tambah laporan pengeluaran (pembelian stok, biaya) dan jadwal ekspor bulanan pemasukan–pengeluaran | Designer + Programmer | Mayor | Pemilik tidak punya laporan S02 yang diminta KAK; keputusan stok/keuangan salah |
| KOR-05 | Tulis user manual bergambar Bahasa Indonesia + quick guide pemilik (alur jual, stok, laporan, ganti password) | Designer (KAK: pelatihan) | Mayor | Karyawan salah input; ketergantungan pada vendor; KAK-D04 gagal |
| KOR-06 | Surat garansi 3 bulan: kanal tiket, SLA defect kritis 5 hari kerja, uji regresi tiap patch | PM | Mayor | Cacat produksi tidak tertangani; KAK-K03 dilanggar |

## 4. Rekomendasi preventif (agar tidak terulang)

| ID | Tindakan | Dampak jika diabaikan |
| --- | --- | --- |
| PRE-01 | Review Requirements vs fitur produk **sebelum** Design ditutup (risiko R01 di SQAP). Fitur wajib yang tidak ada di uniCenta harus jadi gap analysis tertulis. | Produk jadi “lolos coding” tetapi gagal KAK, seperti T06 sekarang |
| PRE-02 | Definition of Done rilis: 100% KAK-T wajib Pass, 0 defect kritis | Serah terima premature |
| PRE-03 | Checklist keamanan di gerbang Implementation: no default empty password, no secret di berkas polos | Ulangi DEF-02/DEF-03 di toko lain |
| PRE-04 | Template dokumentasi (KAK-D, KAK-P) diisi paralel fase, bukan di akhir | Dokumentasi selalu “nanti” lalu tidak ada |
| PRE-05 | CCB untuk perubahan (SQAP pasal 8); jangan diam-diam menambah/mengurangi gaji | Waterfall kaku tanpa jejak, atau scope creep |
| PRE-06 | Pertahankan uji otomatis SQL (`tests/run_sqa_tests.py`) di regresi garansi | Patch merusak stok tanpa ketahuan |

## 5. Evaluasi sistem pengujian ke depan

1. Pertahankan RTM hidup: setiap perubahan KAK menambah kasus uji.
2. Tambah uji GUI terarah (bukan Selenium — aplikasi Swing): skrip checklist kasir + bukti screenshot.
3. Uji keamanan berikutnya: hak akses Employee tidak boleh ubah pajak/user (otorisasi), ganti password, hak file properties.
4. UAT pemilik Toko XXX memakai skenario T01–T06, bukan skenario vendor Inggris.
5. Metrik gerbang: % Pass wajib, defect terbuka per keparahan — dilaporkan mingguan (KAK-P02).

## 6. Keputusan untuk stakeholder

SQA **tidak merekomendasikan** serah terima penuh ke Toko XXX pada kondisi sekarang.

Opsi:

1. **Perbaiki dulu** (disarankan): KOR-01 segera; KOR-02 adendum + jadwal; sisanya dalam garansi tertulis.
2. **Terima terbatas:** POS dipakai hanya untuk kasir+stok, gaji tetap Excel, waiver tertulis pemilik untuk T06 — tetap wajib KOR-01.
3. **Tolak produk:** jika pemilik menuntut seluruh KAK dalam 45 hari tanpa adendum.

Anggaran Rp 25.000.000 tidak boleh dipakai sebagai alasan menghapus T06 tanpa tanda tangan pemilik.
