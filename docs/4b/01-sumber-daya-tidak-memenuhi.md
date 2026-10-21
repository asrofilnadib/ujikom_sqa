# 4B — Pertanyaan 1: Sumber daya SQA tidak memenuhi

**Lingkup penyajian (Kelompok 1):** metodologi, lingkup QA produk/proses, integrasi QA ke organisasi, risiko, **sumber daya**.  
**Pertanyaan asesor:** Apa yang perlu dilakukan jika ternyata sumber daya yang diperlukan dalam pelaksanaan penjaminan mutu pengembangan perangkat lunak **dalam perjalanannya tidak memenuhi**?  
**Acuan kompetensi:** CMS (dan E1, E2, E3, E4, E5, E6 pada lembar penilaian).

---

## Jawaban singkat (buka presentasi)

Saya tidak melanjutkan fase berikutnya seolah-olah tidak ada masalah. Saya **identifikasi gap**, **laporkan ke PM dan stakeholder**, lalu **pilih mitigasi** yang terdokumentasi: tambah resource, adendum kontrak, atau kurangi lingkup **penunjang** — bukan kebutuhan wajib KAK tanpa persetujuan tertulis.

---

## Langkah yang saya lakukan

### 1. Bandingkan rencana vs kenyataan

Sumber daya di SQAP (pasal sumber daya) saya bandingkan dengan yang tersedia:

| Jenis sumber daya | Rencana (contoh proyek Toko XXX) | Gejala tidak memenuhi |
| --- | --- | --- |
| Manusia | PM, designer, programmer, **SQA 1 orang**, pemilik toko untuk UAT | SQA merangkap programmer; tidak ada waktu uji |
| Waktu | 45 hari kerja; Verification minggu 7–8 | Uji terpotong; laporan mingguan kosong |
| Anggaran | Rp 25.000.000 | Tool berbayar, pelatihan, atau modul tambahan tidak kebeli |
| Perangkat | Mesin client, MySQL, aplikasi POS | Satu laptop untuk dev + uji |
| Tool QA | Rencana otomatis + manual | Tool rekomendasi tidak terpasang |

Gap dicatat di **defect log / risiko** dengan ID (misalnya mengacu risiko R06, R07 di SQAP).

### 2. Eskalasi ke pemilik keputusan

- **Project Manager** wajib tahu lebih dulu (RACI: PM accountable).
- **Pemilik Toko XXX** dilibatkan jika yang kurang mempengaruhi **kewajiban KAK** (gaji, manual, garansi).
- Laporan mengikuti **KAK-P02** (mingguan): status gerbang, resource gap, dampak jadwal.

Tanpa eskalasi, SQA tidak independen dan melanggar prinsip integrasi QA ke organisasi (unit 006.1).

### 3. Pilih respons (mitigasi)

Sesuai SQAP pasal risiko dan CCB:

1. **Tambah resource** — contoh: alokasi jam SQA tambahan, bantuan tester manual, sewa lingkungan uji.
2. **Adendum kontrak** — jika anggaran/waktu tidak cukup untuk seluruh KAK-T wajib; jadwal baru tertulis.
3. **Prioritas MoSCoW** — fitur **penunjang** ditunda; **wajib** (stok, transaksi DB, keamanan dasar, gaji jika di KAK) tidak dipotong diam-diam.
4. **Alihkan risiko** — asuransi/garansi diperjelas (KAK-D05) bila tim kecil.
5. **Terima risiko** — hanya dengan **waiver tertulis** pemilik, bukan keputusan programmer.

Yang **tidak** saya lakukan: mengurangi cakupan uji wajib tanpa catatan; melewati gerbang Verification; menyembunyikan gap ke asesor atau pemilik.

### 4. Perbarui dokumen QA

- Update **SQAP** atau addendum (jadwal uji, alokasi orang).
- Update **RTM** jika kasus uji tidak bisa dijalankan (N/A dengan alasan).
- Putuskan **exit criteria** fase: Verification tidak ditutup jika resource tidak cukup untuk menjalankan kasus wajib.

### 5. Contoh konkret (proyek uniCenta / Toko XXX)

Jika anggaran tidak cukup untuk modul **gaji (KAK-T06)** tetapi POS inti sudah jalan:

- Saya laporkan sebagai **gap requirement**, bukan Pass palsu.
- Opsi: integrasi payroll terpisah + adendum, atau waiver pemilik (gaji tetap Excel) dengan tanggal perbaikan di garansi 3 bulan.
- SQA tetap menjalankan uji yang **bisa** dilakukan (stok, transaksi, keamanan) dengan resource yang ada.

---

## Penutup untuk asesor

Kesimpulan: sumber daya tidak memenuhi adalah **temuan manajemen**, bukan alasan mengabaikan mutu. Tindakannya **terukur** (laporan, CCB, adendum/waiver) dan **terhubung ke KAK serta SQAP**, sehingga jejak audit tetap ada meski proyek memakai model waterfall yang kaku.
