# Prompt ChatGPT untuk PPT 4A

Tiga file di folder ini untuk membuat presentasi **masing-masing maksimal 5 slide**, selaras dokumen PDF/markdown di repo `ujikom_sqa`.

| File | Kelompok | Waktu presentasi (asesmen) | Sumber isi utama |
| --- | --- | --- | --- |
| [kelompok-1-chatgpt-prompt.md](kelompok-1-chatgpt-prompt.md) | Pre Development — Rencana SQA | **10 menit** | `docs/kelompok-1/Rencana-Penjaminan-Kualitas-Software.md` |
| [kelompok-2-chatgpt-prompt.md](kelompok-2-chatgpt-prompt.md) | Development — Hasil uji | **5 menit** | `docs/kelompok-2/Matriks-Hasil-Pengujian.md`, `Skenario-Pengujian.md` |
| [kelompok-3-chatgpt-prompt.md](kelompok-3-chatgpt-prompt.md) | Post Development — Rekomendasi | **5 menit** | `docs/kelompok-3/Rekomendasi-Penjaminan-Kualitas.md` |

## Cara pakai

1. Buka ChatGPT (atau alat PPT: Gamma, Copilot, Canva AI).
2. Salin **seluruh isi** blok prompt dari file kelompok yang sesuai (dari baris `---PROMPT---` sampai `---AKHIR PROMPT---`).
3. Opsional: lampirkan PDF kelompok yang sama dari `docs/pdf/` agar angka/temuan tidak berubah.
4. Minta output **PowerPoint** (`.pptx` outline), atau **teks per slide** untuk ditempel manual.
5. Setelah jadi, sesuaikan nama asesi, tanggal, dan screenshot lab jika ada di `docs/bukti/`.

**Catatan:** uniCenta oPOS adalah **SUT** (yang diuji), bukan alat testing. Jangan ubah fakta uji (misalnya jangan tulis T06 Pass atau “tidak ada defect kritis”).
