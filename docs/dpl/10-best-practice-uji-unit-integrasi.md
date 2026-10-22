# DPL No. 10 — Best practice uji unit & integrasi

**KUK:** U9.E1.KUK2, U9.E1.KUK3  

**Pertanyaan:** Apakah ada best practice acuan prosedur uji unit atau integrasi?

## Jawaban Asesi

- Acuan utama adalah **ISO/IEC/IEEE 29119** (standar pengujian perangkat lunak) dan praktik umum **ISTQB** (*International Software Testing Qualifications Board* — kerangka sertifikasi pengujian).
- **Uji unit** mengisolasi komponen terkecil yang dapat diuji; pada produk vendor tertutup, cakupannya terbatas dibanding **uji integrasi**.
- **Uji integrasi** memverifikasi antarmuka antara aplikasi **POS**, konektor **JDBC** (*Java Database Connectivity*), dan **MySQL**.
- Praktik baik yang diterapkan: langkah uji jelas di skenario, data uji terkontrol (seed Toko XXX), expected diambil dari **KAK**, dan konsistensi data diverifikasi setelah transaksi.
- Contoh pada proyek: **TC-I-01** memastikan pembayaran tercatat di tabel `payments`; **TC-I-02** memastikan stok di `stockcurrent` berkurang setelah penjualan.
