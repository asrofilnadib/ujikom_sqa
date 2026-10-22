# DPL No. 3 — Batasan aktivitas uji penjaminan mutu

**KUK:** U3.E3.KUK2, U3.E3.KUK3, U3.E3.KUK4  

**Pertanyaan:** Sesuai metode yang dipilih, apa saja batasan aktivitas yang diperlukan dalam proses uji penjaminan mutu?

## Jawaban Asesi

- **Lingkup produk** mencakup kebutuhan fungsional **KAK-T01** sampai **T06**, integrasi aplikasi **POS** (*Point of Sale* — kasir) dengan **MySQL**, uji keamanan defensif, dan tinjauan **white box** (uji melalui struktur data dan konfigurasi); di luar lingkup ada eksploitasi ofensif dan data produksi riil pelanggan.
- **Lingkup waktu** mengikuti fase **Verification** (verifikasi) pada jadwal **SQAP** (*Software Quality Assurance Plan*) empat puluh lima hari kerja.
- **Peran SQA** (*Software Quality Assurance*) harus independen dari programmer, dan status Pass atau Fail hanya boleh diisi jika ada bukti berupa screenshot, kueri **SQL** (*Structured Query Language*), atau berkas **JSON** hasil otomatis.
- **Teknik GUI** pada aplikasi **Swing** (antarmuka desktop Java) dilakukan manual terstruktur; otomatisasi dibatasi pada skrip **SQL** dan **Python** bila otomatisasi layar tidak realistis di lab.
- Uji dimulai setelah build lab siap, basis data dummy Toko XXX tersedia, dan skenario pengujian disetujui **PM** (*Project Manager* — manajer proyek).
