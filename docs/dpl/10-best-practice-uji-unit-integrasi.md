# DPL No. 10 — Best practice uji unit & integrasi

**KUK:** U9.E1.KUK2, U9.E1.KUK3  

**Pertanyaan:** Apakah ada best practice acuan prosedur uji unit atau integrasi?

## Jawaban Asesi

Acuannya ISO/IEC/IEEE 29119 dan praktik umum ISTQB: uji unit mengisolasi komponen terkecil, uji integrasi menguji antarmuka antar komponen. Best practice yang saya terapkan: langkah jelas di skenario, data uji terkontrol (seed Toko XXX), expected dari KAK bukan dari asumsi kode, dan verifikasi konsistensi data setelah transaksi. Pada uniCenta, integrasi POS–MySQL diuji lewat pembayaran cash tersimpan di `payments` dan stok turun di `stockcurrent` (TC-I-01, TC-I-02), sementara unit logika dalam kode vendor terbatas sehingga fokus SQA pada integrasi dan uji sistem end-to-end kasir.
