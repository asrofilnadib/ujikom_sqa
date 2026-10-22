# DPL No. 11 — Penilaian tingkat keamanan per aspek uji

**KUK:** U10.E2.KUK2  

**Pertanyaan:** Apa yang dimaksud penilaian tingkat keamanan perangkat lunak berdasarkan hasil tiap aspek pengujian?

## Jawaban Asesi

- Penilaian keamanan dilakukan **per aspek**, antara lain autentikasi (login), otorisasi (hak peran), kerahasiaan data, dan integritas input, masing-masing dengan kasus uji, expected, actual, dan tingkat keparahan.
- Hasil per aspek digabung menjadi kesimpulan apakah produk layak dirilis ke Toko XXX dari sisi keamanan.
- Pada **uniCenta oPOS**, aspek autentikasi gagal karena password default kosong (**DEF-02**), kerahasiaan gagal karena password basis data tersimpan polos di berkas properties (**DEF-03**), sementara uji input literal **SQL** masih aman.
- Kesimpulan keseluruhan tidak memenuhi **KAK-K01** (kerahasiaan data perusahaan), sehingga rilis ditahan hingga **KOR-01** dan **KOR-03** diterapkan.
- Bukti didokumentasikan pada matriks kasus **TC-S** (keamanan) dan **TC-W** (white box) beserta screenshot atau kueri basis data.
