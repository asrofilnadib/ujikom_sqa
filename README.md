# Ujikom SQA — uniCenta oPOS vs KAK Toko XXX

Asesmen 4A skema Software Quality Assurance (`SS-LSP.UEU-002-2020`). uniCenta oPOS adalah **perangkat lunak yang diuji**, bukan alat testing.

## Deliverable

| Kelompok | Isi | PDF |
| --- | --- | --- |
| 1 Pre Development | [Rencana penjaminan kualitas](docs/kelompok-1/Rencana-Penjaminan-Kualitas-Software.md), [RTM](docs/kelompok-1/RTM-Kebutuhan.md) | `docs/pdf/` |
| 2 Development | [Verifikasi tahap](docs/kelompok-2/Verifikasi-Tahap-Pengembangan.md), [skenario](docs/kelompok-2/Skenario-Pengujian.md), [matriks](docs/kelompok-2/Matriks-Hasil-Pengujian.md) | `docs/pdf/` |
| 3 Post Development | [Rekomendasi](docs/kelompok-3/Rekomendasi-Penjaminan-Kualitas.md) | `docs/pdf/` |
| Presentasi | [PPT HTML](docs/ppt/) (5 + 3 + 3 halaman); [prompt ChatGPT](docs/ppt/prompts/) (maks. 5 slide/kelompok) | `docs/pdf/01-rencana-kualitas.pdf` dst. |

4B dan wawancara lisan belum dikerjakan.

## Lab uniCenta

Lihat [install/CATATAN-INSTALASI.md](install/CATATAN-INSTALASI.md).

```
./install/scripts/start-unicenta.sh
python3 tests/run_sqa_tests.py
```

Login bawaan: Administrator / Manager / Employee / Guest dengan **password kosong** (temuan DEF-02).
