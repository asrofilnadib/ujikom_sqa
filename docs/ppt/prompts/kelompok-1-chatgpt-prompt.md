# Prompt PPT — Kelompok 1 (Rencana Penjaminan Kualitas)

Salin dari `---PROMPT---` sampai `---AKHIR PROMPT---`.

---PROMPT---

Kamu adalah desainer presentasi profesional untuk asesmen kompetensi **Software Quality Assurance** skema **SS-LSP.UEU-002-2020** (unit J.625QA00.001.1–006.1), tahap **4A Kelompok 1 — SQA Pre Development**.

Buatkan **outline presentasi PowerPoint persis 5 slide** (bukan 4, bukan 6). Bahasa **Indonesia** formal tetapi mudah diucapkan. Target waktu bicara **10 menit** (~2 menit per slide). Gaya: ringkas, berbasis fakta, cocok untuk asesor LSP — hindari paragraf panjang di slide (maksimal 5 bullet per slide, maksimal ~12 kata per bullet).

## Konteks proyek (wajib konsisten)

- **Proyek:** Sistem Kasir Point of Sales — **Toko XXX**
- **Organisasi pengembang:** Organisasi XYZ
- **Perangkat lunak yang dijamin kualitasnya (SUT):** **uniCenta oPOS 5.0** (kandidat POS desktop + MySQL) — ini **bukan** alat testing
- **Acuan kebutuhan:** KAK Sistem Kasir POS Toko XXX (waterfall 45 hari kerja, anggaran Rp 25.000.000)
- **Dokumen SQAP:** SQAP-XYZ-POS-001, versi 1.0, **21 Oktober 2026**
- **Penyusun:** Mohammad Asrofil Nadhif (Software Quality Assurance)
- **Pesan inti:** SQA **tidak mengganti** waterfall KAK; SQA menempelkan **quality gate** di akhir tiap fase dengan **ketertelusuran ID** KAK (KAK-Txx, KAK-Sxx, KAK-Dxx) sampai ke kasus uji Kelompok 2

## Isi yang harus tercakup (komprehensif, tersebar di 5 slide)

**Slide 1 — Judul & positioning**
- Judul: Rencana Penjaminan Kualitas Software — POS Toko XXX
- Subjudul: Kelompok 1 · SQA Pre Development · 10 menit
- Meta: standar acuan (IEEE 730, ISO 12207, ISO 25010, ISO/IEC/IEEE 29119), prinsip independensi SQA (tidak merangkap programmer)

**Slide 2 — Metodologi & kerangka**
- Tabel atau bullet: IEEE 730 → SQAP; ISO 12207 + waterfall KAK → gerbang fase; ISO 25010 → mutu produk; ISO 29119 → skenario & matriks uji
- Teknik uji yang direncanakan: black box, white box, integrasi, stress, keamanan, manual GUI, otomatis SQL ringan
- Prinsip: bukti (screenshot/log/kueri), bukan opini

**Slide 3 — Lingkup QA produk & proses**
- **Wajib lulus (KAK):** T01 ganti Excel; T02–T03 transaksi ke DB; T04 stok real time; T05/S02 laporan pemasukan & pengeluaran bulanan; **T06 gaji karyawan**; D01 peran karyawan & admin; K01 kerahasiaan data
- **Proses:** fase tidak tumpang tindih (KAK-W); exit criteria tertulis; deliverable dokumentasi, manual bergambar, **garansi 3 bulan**
- **Di luar lingkup:** hardware printer, toko online, sertifikasi ISO organisasi

**Slide 4 — Pelaksanaan 45 hari, organisasi, sumber daya**
- Jadwal ringkas (minggu 1 Requirements → … → minggu 9 serah terima + 3 bulan garansi)
- RACI singkat: PM akuntabel rilis; SQA responsible pengujian & temuan; pemilik Toko XXX approve serah terima
- Sumber daya: 1 SQA (asesi), lab Ubuntu + MySQL 8, waktu terbatas — rencana subset standar yang **terbukti** di proyek

**Slide 5 — Risiko, change control, Definition of Done**
- Risiko utama: R01 gaji tidak ada; R02 stok salah; R03 laporan tidak otomatis; R04 bocor data; R05 perubahan vs waterfall
- CCB (PM, Designer, SQA, pemilik); impact analysis & regresi; SLA garansi defect kritis 5 hari kerja
- **DoD rilis:** 100% kasus wajib dieksekusi, **0 defect kritis**, deliverable D02–D05 ada — tanpa itu **tidak rilis**

## Format output yang diminta

Untuk **setiap slide (1–5)** berikan:

1. **Judul slide**
2. **Konten slide** (bullet atau tabel ringkas, siap tempel ke PowerPoint)
3. **Catatan pembicara** (60–90 detik, bahasa lisan Indonesia)
4. **Saran visual** (ikon, diagram gerbang fase, atau tabel — jangan stock photo generik)

Di akhir, tambahkan **1 slide cadangan “Q&A”** (opsional, tidak dihitung dalam 5 slide utama) berisi 3 pertanyaan asesor yang mungkin muncul beserta jawaban 1 kalimat (contoh: sumber daya tidak memenuhi rencana).

Warna disarankan: biru gelap **#1F4E79** untuk judul/header, teks gelap #1A1A1A, latar terang.

Jangan mengarang fitur yang tidak ada di KAK. Jangan menyatakan uji sudah selesai — ini slide **rencana**, bukan hasil uji.

---AKHIR PROMPT---
