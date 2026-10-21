# 4B — Pertanyaan 2: Tool otomatis tidak tersedia, waktu terbatas

**Lingkup penyajian (Kelompok 2):** verifikasi tahap pengembangan, uji manual, **uji otomatis**, uji keamanan.  
**Pertanyaan asesor:** Jika pelaksanaan SQA secara otomatis tetapi **tools yang direkomendasikan tidak tersedia**, hanya **tools yang ada**, dan **waktu terbatas** — apa yang perlu dilakukan?  
**Acuan kompetensi:** TS, TRS, TMS (dan E7–E10 pada lembar penilaian).

---

## Jawaban singkat (buka presentasi)

Saya **tidak mengganti rencana dengan omong kosong**. Saya **reprioritisasi**: kasus wajib KAK dulu, otomatisasi **substitusi yang jujur** (misalnya skrip SQL + klien DB untuk integritas data), sisanya **manual terstruktur**, semua tercatat di skenario dan matriks dengan status dan bukti — bukan mengaku sudah pakai tool yang tidak pernah dijalankan.

---

## Konteks proyek saya (uniCenta oPOS)

- Aplikasi **desktop Java (Swing)**, bukan web — Selenium/UI automation sering **tidak realistis** dalam 60 menit asesmen.
- Rencana SQAP tetap menyebut otomatis + manual; di lab saya memakai **MySQL client** dan **`tests/run_sqa_tests.py`** untuk cek stok, pembayaran, skema.
- Tool “rekomendasi” tingkat enterprise (JMeter penuh, lisensi berbayar, plugin khusus) **tidak wajib** selama **tujuan uji** tercapai dan **terdokumentasi**.

---

## Langkah yang saya lakukan

### 1. Kembali ke tujuan uji, bukan nama tool

Dari SQAP dan KAK, saya urutkan:

| Prioritas | Jenis uji | Contoh kebutuhan KAK |
| --- | --- | --- |
| P1 | Fungsional + integrasi DB | T03, T04, T05 — transaksi, stok, pembayaran |
| P2 | Keamanan defensif | K01, D01 — password, role, kredensial |
| P3 | Stress ringan | T04 — kueri stok berulang / BENCHMARK |
| P4 | Otomatis GUI penuh | Nice-to-have jika tool tidak ada |

Waktu terbatas → **P1 dan P2** harus selesai dengan bukti; P4 boleh N/A dengan alasan teknis.

### 2. Substitusi tool (yang ada di mesin)

| Rencana ideal | Substitusi yang saya pakai | Bukti |
| --- | --- | --- |
| Automation GUI | Manual black box + checklist kasir | Screenshot / catatan langkah di matriks |
| API test otomatis | Kueri SQL + skrip Python ke `unicentaopos` | `hasil-otomatis.json`, output mysql |
| Load test JMeter | `BENCHMARK` / join stok di MySQL | TC-ST-01, TC-ST-02 |
| Security scanner komersial | Review `unicentaopos.properties`, cek `people.apppassword`, peran | TC-S-03, TC-W-01 |

Prinsip **TRS**: setiap kasus punya **expected / actual / status** — tidak peduli tool-nya apa.

### 3. Tetap patuh dokumen 4A

- **Skenario pengujian** diperbarui: kolom jenis uji jelas (manual / otomatis / white box).
- **Matriks hasil** tidak diisi “Pass” tanpa eksekusi.
- Kasus yang **tidak dijalankan** → status **N/A** atau **Deferred** + alasan (tool, waktu), disetujui PM.

Ini memenuhi spirit **TMS**: traceability dari rencana ke hasil.

### 4. Manajemen waktu (60 menit / terbatas)

1. Smoke: aplikasi jalan + koneksi DB (5 menit).
2. Jalankan skrip otomatis ringan (5–10 menit).
3. Manual: satu alur jual barang + cek stok (15 menit).
4. Keamanan: login default, file properties (10 menit).
5. Isi matriks + defect (sisanya).

Tidak membuka tool baru yang belum pernah diuji di lab — itu risiko false Pass.

### 5. Komunikasi ke stakeholder

Saya sampaikan ke PM/pemilik:

- Cakupan otomatis **sebagian** terpenuhi dengan substitusi.
- Keterbatasan (misalnya tidak ada uji beban 1000 user) dan **dampak** (risiko performa produksi belum teruji penuh).
- Rekomendasi **pasca-rilis**: tool tambahan di fase garansi jika anggaran ada.

---

## Penutup untuk asesor

Tool yang direkomendasikan tidak tersedia **bukan alasan** melewatkan SQA. Yang dilakukan: **prioritas KAK**, **substitusi terukur**, **manual terstruktur**, **dokumentasi jujur** di skenario dan matriks — sesuai ISO/IEC/IEEE 29119 dan rencana SQAP proyek Toko XXX.
