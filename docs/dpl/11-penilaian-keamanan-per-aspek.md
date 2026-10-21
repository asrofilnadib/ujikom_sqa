# DPL No. 11 — Penilaian tingkat keamanan per aspek uji

**KUK:** U10.E2.KUK2  

**Pertanyaan:** Apa yang dimaksud penilaian tingkat keamanan perangkat lunak berdasarkan hasil tiap aspek pengujian?

## Jawaban Asesi

Penilaian keamanan dilakukan per aspek—autentikasi, otorisasi, kerahasiaan data, integritas input—masing-masing punya kasus uji, expected, actual, dan keparahan, lalu digabung menjadi kesimpulan layak atau tidak layak rilis. Pada uniCenta: autentikasi gagal karena password default NULL (kritis), kerahasiaan gagal karena password database polos di properties, otorisasi sebagian karena peran ada tetapi Guest dan admin tanpa password berisiko, integritas input aman pada uji literal SQL. Keseluruhan tidak memenuhi KAK-K01 sehingga rilis ditahan sampai KOR-01 dan KOR-03, dengan bukti di matriks TC-S dan TC-W.
