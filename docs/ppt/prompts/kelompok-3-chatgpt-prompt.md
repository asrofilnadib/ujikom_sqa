# Prompt PPT — Kelompok 3 (Rekomendasi Penjaminan Kualitas)

Salin dari `---PROMPT---` sampai `---AKHIR PROMPT---`.

---PROMPT---

Kamu adalah desainer presentasi profesional untuk asesmen **Software Quality Assurance** skema **SS-LSP.UEU-002-2020**, tahap **4A Kelompok 3 — SQA Post Development** (rekomendasi ke stakeholder).

Buatkan **outline presentasi PowerPoint persis 5 slide** (bukan 4, bukan 6). Bahasa **Indonesia**. Target waktu **5 menit**. Nada: **tegas, berbasis bukti uji Kelompok 2**, orientasi keputusan bisnis untuk pemilik Toko XXX dan PM Organisasi XYZ.

## Konteks (wajib konsisten)

- **Dokumen:** REC-XYZ-POS-001, **21 Oktober 2026**
- **Acuan:** KAK Toko XXX, SQAP-XYZ-POS-001 (Kelompok 1), TR-XYZ-POS-001 (Kelompok 2)
- **SUT:** uniCenta oPOS 5.0
- **Penyusun:** Mohammad Asrofil Nadhif (SQA)
- **Kesimpulan uji:** kasir, stok, dan integrasi DB **ada**; **gaji, keamanan akun, manual bergambar, garansi 3 bulan** **tidak memenuhi KAK**
- **Posisi SQA:** **Tidak merekomendasikan serah terima penuh** pada kondisi sekarang

## Data kesesuaian KAK (untuk slide tabel)

Gunakan penilaian ini (jangan dibalik):

| KAK | Status ringkas |
| --- | --- |
| T01, S01 | Sesuai — POS desktop jalan |
| T02 | Sebagian — bisa catat transaksi, tanpa panduan ID Toko XXX |
| T03 | Sesuai — data di MySQL |
| T04 | Sesuai — stok real time |
| T05, S02 | Sebagian — pemasukan ok, pengeluaran tidak lengkap |
| **T06** | **Tidak sesuai** — tidak ada modul gaji |
| D01 | Sebagian — peran ada, password kosong |
| D02–D04, A01–A02 | **Tidak sesuai** — manual Toko XXX tidak ada |
| D05, K03 | **Tidak sesuai** — garansi 3 bulan tidak terbukti |
| K01 | **Tidak sesuai** — DEF-02, DEF-03 |
| W, P | Tidak terbukti — jejak waterfall vendor |

**Ketercapaian fungsi wajib T01–T06:** 3 penuh (T01, T03, T04); T02 & T05 sebagian; **T06 nol**.

## Isi rekomendasi (harus masuk slide)

**Korektif (perbaiki sekarang):**
- **KOR-01** — Wajibkan password; nonaktifkan Guest di toko (kritis, sebelum UAT)
- **KOR-02** — Modul gaji atau payroll terpisah + adendum KAK jika ditunda (T06)
- **KOR-03** — Jangan simpan password DB polos di properties
- **KOR-04** — Laporan pengeluaran + rekap bulanan pemasukan–pengeluaran
- **KOR-05** — User manual bergambar Bahasa Indonesia + quick guide pemilik
- **KOR-06** — Surat garansi 3 bulan, kanal tiket, SLA kritis 5 hari kerja

**Preventif (agar tidak terulang):**
- **PRE-01** — Gap analysis fitur vs KAK sebelum Design ditutup (akar masalah T06)
- **PRE-02** — DoD rilis: 100% KAK-T wajib Pass, 0 kritis
- **PRE-03** — Checklist keamanan di gerbang Implementation
- **PRE-04** — Template dokumentasi diisi paralel fase
- **PRE-05** — CCB untuk perubahan scope
- **PRE-06** — Pertahankan regresi `tests/run_sqa_tests.py` + checklist GUI manual

**Sistem uji ke depan:** RTM hidup; UAT pemilik pakai skenario T01–T06; metrik mingguan % Pass & defect terbuka (KAK-P02).

**Keputusan stakeholder (3 opsi):**
1. **Perbaiki dulu** (disarankan) — KOR-01 segera, KOR-02 dengan jadwal/adendum
2. **Terima terbatas** — POS hanya kasir+stok, gaji tetap Excel, **waiver tertulis** untuk T06; tetap wajib KOR-01
3. **Tolak produk** — jika seluruh KAK dituntut dalam 45 hari tanpa adendum

Tegaskan: anggaran Rp 25.000.000 **bukan** alasan menghapus T06 tanpa persetujuan pemilik.

## Struktur 5 slide

**Slide 1 — Judul & rekomendasi utama**
- Judul: Rekomendasi Penjaminan Kualitas — POS Toko XXX
- Sub: Kelompok 3 · 5 menit
- Kalimat besar: **Tidak rekomendasikan serah terima penuh** + alasan 1 baris (kritis + T06)

**Slide 2 — Evaluasi SQA & kesesuaian KAK**
- Bullet “yang berjalan baik” (ketertelusuran, integrasi, stok, peran, kinerja lab)
- Bullet “yang tidak memadai” (gerbang gagal, dokumentasi, garansi)
- Tabel ringkas KAK T01–T06 + K01 (maks 8 baris)

**Slide 3 — Rekomendasi korektif (KOR-01–KOR-06)**
- Tabel: Kode | Tindakan | Prioritas | Dampak jika diabaikan
- Sorot KOR-01 dan KOR-02

**Slide 4 — Rekomendasi preventif & pengujian ke depan**
- PRE-01 s.d. PRE-06 (bullet atau tabel 2 kolom)
- Satu baris: regresi otomatis + checklist GUI Swing (bukan Selenium)

**Slide 5 — Keputusan untuk stakeholder**
- Tiga opsi (perbaiki / terima terbatas / tolak) dengan syarat masing-masing
- Call to action: PM jadwalkan perbaikan; pemilik putuskan waiver atau tidak

## Format output

Per slide: **Judul**, **Konten**, **Catatan pembicara** (45–60 detik), **Saran visual** (diagram “jembatan” Kelompok 1→2→3, atau traffic light merah/kuning/hijau untuk KAK).

Di akhir (opsional, luar 5 slide): 2 jawaban singkat untuk wawancara 4B — “QA vs rencana” dan “tindakan jika tidak sesuai rencana”.

Warna: **#1F4E79** header; peringatan **#8B0000** untuk kritis/T06.

Jangan mengubah fakta uji (jangan klaim serah terima aman). Jangan menghapus T06 dari rekomendasi.

---AKHIR PROMPT---
