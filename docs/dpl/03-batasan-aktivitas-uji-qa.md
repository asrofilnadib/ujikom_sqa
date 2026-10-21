# DPL No. 3 — Batasan aktivitas uji penjaminan mutu

**KUK:** U3.E3.KUK2, U3.E3.KUK3, U3.E3.KUK4  

**Pertanyaan:** Sesuai metode yang dipilih, apa saja batasan aktivitas yang diperlukan dalam proses uji penjaminan mutu?

## Jawaban Asesi

Batasan aktivitas mengatur lingkung (apa yang diuji), waktu (fase Verification), sumber daya, dan teknik yang dipakai. Pada proyek POS Toko XXX yang diuji: fungsional KAK-T01–T06, integrasi POS–MySQL, keamanan defensif K01, white box konfigurasi, dan stress ringan stok; di luar lingkup eksploitasi ofensif, data produksi riil, dan pengembangan POS dari nol. Uji dimulai setelah build lab siap, SQA independen dari programmer, dan status Pass/Fail hanya dengan bukti screenshot, kueri SQL, atau JSON otomatis; jika otomatis GUI tidak realistis untuk aplikasi Swing, otomatis dibatasi ke skrip SQL/Python dan GUI diuji manual terstruktur sesuai skenario.
