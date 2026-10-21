# 4B — Pertanyaan 3: Analisis kesesuaian QA dengan rencana

**Lingkup penyajian (Kelompok 3):** rekomendasi QA ke stakeholder, **evaluasi pelaksanaan** penjaminan kualitas.  
**Pertanyaan asesor:** Bagaimana cara menganalisis **kesesuaian pelaksanaan Quality Assurance (QA) dengan rencana**, dan jika **tidak sesuai** apa yang harus dilakukan?  
**Acuan kompetensi:** TMS, CMS, JRES (dan E11, E12 pada lembar penilaian).

---

## Jawaban singkat (buka presentasi)

Saya bandingkan **rencana (SQAP + RTM)** dengan **hasil (matriks uji + defect log)** per ID kebutuhan KAK. Kalau tidak sesuai, saya keluarkan **rekomendasi korektif dan preventif** dengan dampak, dan **tidak merekomendasikan rilis** selama defect kritis dan kebutuhan wajib masih gagal — kecuali ada **waiver tertulis** pemilik.

---

## Cara menganalisis kesesuaian

### 1. Tiga lapis perbandingan

```text
KAK (kebutuhan bisnis)
    ↓  RTM
SQAP (rencana: apa yang diuji, kapan, siapa)
    ↓  skenario + eksekusi
Matriks hasil + defect log (bukti)
    ↓
Rekomendasi + keputusan rilis
```

| Lapisan | Dokumen | Pertanyaan analisis |
| --- | --- | --- |
| Kebutuhan | KAK-T01–T06, KAK-S, KAK-D | Apakah setiap wajib punya kasus uji? |
| Rencana | SQAP, RTM | Apakah uji yang dijanjikan benar-benar dijalankan? |
| Hasil | Matriks, `hasil-otomatis.json` | Pass/Fail/N/A sesuai bukti? |
| Proses | Verifikasi tahap waterfall | Gerbang fase terpenuhi atau tidak? |

**TMS (traceability):** setiap baris matriks bisa ditelusuri ke `KAK-xx` dan ke pasal SQAP.

### 2. Kriteria “sesuai rencana”

Dari **Definition of Done** SQAP:

- 100% kasus uji **wajib** dieksekusi (bukan hanya ditulis).
- **0 defect kritis** terbuka.
- Defect mayor punya rencana perbaikan atau waiver.
- Deliverable KAK-D (manual, dokumentasi, garansi) ada atau dicatat gagal.

Jika rencana bilang “uji keamanan” tetapi matriks kosong → **tidak sesuai proses**, bukan hanya produk.

### 3. Contoh analisis proyek uniCenta vs KAK

| KAK | Rencana SQAP | Hasil uji | Kesesuaian |
| --- | --- | --- | --- |
| T01, T03, T04 | Uji POS + DB + stok | Pass, stok 20→19 | **Sesuai** |
| T05, S02 | Laporan pemasukan/pengeluaran | Pemasukan bulanan ada; pengeluaran tidak lengkap | **Sebagian** |
| T06 | Uji gaji | Tidak ada modul/tabel gaji | **Tidak sesuai** |
| K01, D01 | Uji keamanan | Password NULL; password DB polos | **Tidak sesuai** |
| D02–D05 | Deliverable dokumentasi/garansi | Tidak ada untuk Toko XXX | **Tidak sesuai** |

**CMS:** kesesuaian diukur terhadap **kontrak KAK**, bukan hanya “aplikasi bisa dibuka”.

### 4. Evaluasi pelaksanaan SQA (unit 012.1)

Saya evaluasi tidak hanya produk, tetapi **apakah SQA dijalankan seperti rencana**:

- Apakah independensi SQA terjaga?
- Apakah temuan dilaporkan (DEF-01 s.d. DEF-07)?
- Apakah gerbang Verification di SQAP dihormati?  
  → Pada proyek ini: **produk boleh diuji**, tetapi **gerbang rilis gagal** karena kritis + T06.

---

## Jika tidak sesuai — apa yang dilakukan

### A. Rekomendasi korektif (perbaiki sekarang)

| Temuan | Tindakan | Dampak jika tidak |
| --- | --- | --- |
| DEF-02 password kosong | KOR-01: wajibkan password, nonaktifkan Guest | Siapa saja bisa akses admin di kasir |
| DEF-01 tidak ada gaji | KOR-02: modul gaji atau integrasi payroll + adendum | KAK-T06 gagal; Excel tetap dipakai |
| DEF-03 kredensial polos | KOR-03: secret management | Database toko bocor |
| DEF-04 laporan tidak lengkap | KOR-04: laporan pengeluaran + rekap bulanan | Keputusan keuangan salah |
| DEF-05/06 dokumentasi & garansi | KOR-05/06: manual ID + SLA garansi | KAK-D gagal; pelatihan toko gagal |

**JRES:** rekomendasi ditujukan ke **stakeholder** (pemilik Toko XXX, PM Organisasi XYZ) dengan bahasa bisnis + teknis.

### B. Rekomendasi preventif (agar tidak terulang)

- **PRE-01:** gap analysis fitur vs KAK **sebelum** Design ditutup (mencegah T06 terlambat ketahuan).
- **PRE-02:** DoD rilis ketat; tidak ada “lulus karena waktu habis”.
- **PRE-03:** checklist keamanan di gerbang Implementation.
- **PRE-04:** dokumentasi paralel, bukan di akhir.
- Regresi: pertahankan skrip uji otomatis ringan setiap patch garansi.

### C. Keputusan formal

1. **Tidak rilis** (disarankan pada kondisi sekarang) sampai KOR-01 dan keputusan T06 jelas.
2. **Rilis terbatas** dengan waiver tertulis (hanya kasir+stok; gaji di Excel) — tetap wajib perbaikan keamanan.
3. **Tolak serah terima** jika pemilik menuntut 100% KAK tanpa adendum.

Semua keputusan melalui **PM + pemilik**, SQA menyediakan bukti matriks — bukan memutus sendiri tanpa stakeholder.

---

## Penutup untuk asesor

Analisis kesesuaian QA dengan rencana = **RTM + matriks + defect**, dibandingkan ke **SQAP dan KAK**. Ketidaksesuaian ditindak dengan **korektif/preventif berdampak**, bukan dengan mengubah status uji tanpa bukti. Itu inti evaluasi pelaksanaan penjaminan kualitas pada proyek Sistem Kasir POS Toko XXX.
