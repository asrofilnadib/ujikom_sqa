# Ujikom SQA — uniCenta oPOS vs KAK Toko XXX

Asesmen 4A skema Software Quality Assurance (`SS-LSP.UEU-002-2020`). uniCenta oPOS adalah **perangkat lunak yang diuji**, bukan alat testing.

## Deliverable

| Kelompok | Isi | PDF |
| --- | --- | --- |
| 1 Pre Development | [Rencana penjaminan kualitas](docs/kelompok-1/Rencana-Penjaminan-Kualitas-Software.md), [RTM](docs/kelompok-1/RTM-Kebutuhan.md) | `docs/pdf/` |
| 2 Development | [Verifikasi tahap](docs/kelompok-2/Verifikasi-Tahap-Pengembangan.md), [skenario](docs/kelompok-2/Skenario-Pengujian.md), [matriks](docs/kelompok-2/Matriks-Hasil-Pengujian.md), [bukti GUI manual](docs/bukti/J.62SQA00.008.1-manual/) | `docs/pdf/` |
| 3 Post Development | [Rekomendasi](docs/kelompok-3/Rekomendasi-Penjaminan-Kualitas.md) | `docs/pdf/` |
| Presentasi | [PPT HTML](docs/ppt/) (5 + 3 + 3 halaman); [prompt ChatGPT](docs/ppt/prompts/) (maks. 5 slide/kelompok) | `docs/pdf/01-rencana-kualitas.pdf` dst. |

| DPL (wawancara lisan FR.IA.07) | [Jawaban 13 pertanyaan](docs/dpl/) | — |
| 4B (setelah presentasi) | [Catatan 3 pertanyaan](docs/4b/) | — |

## Lab uniCenta

Lihat [install/CATATAN-INSTALASI.md](install/CATATAN-INSTALASI.md).

```
./install/scripts/start-unicenta.sh
python3 tests/run_sqa_tests.py
./install/scripts/render-terminal-bukti.sh    # PNG bukti query/konfig
./install/scripts/build-4a-kel2-pdf.sh      # PDF 4.A Kel.2 + lampiran GUI
```

Login bawaan: Administrator / Manager / Employee / Guest dengan **password kosong** (temuan DEF-02).
