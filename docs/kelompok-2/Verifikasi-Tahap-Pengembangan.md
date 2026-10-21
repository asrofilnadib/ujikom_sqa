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
