# DPL No. 4 — Dokumentasi faktor risiko QA

**KUK:** U4.E2.KUK1, U4.E2.KUK2  

**Pertanyaan:** Apa saja dan bagaimana mendokumentasikan faktor risiko yang menunjukkan jaminan kualitas perangkat lunak?

## Jawaban Asesi

- Risiko dicatat dalam **register risiko SQAP** (*Software Quality Assurance Plan*) berisi identifikasi, pemicu, skor dampak dikali probabilitas, mitigasi preventif, kontingensi korektif, dan kaitan ke ID **KAK** (*Kerangka Acuan Kerja*).
- Apabila risiko terjadi, temuan dipindahkan ke **defect log** (*log cacat*), contohnya risiko R01 modul gaji menjadi **DEF-01** pada uji **KAK-T06**.
- Bukti bahwa kontrol berjalan ditunjukkan melalui kasus uji di matriks dan **laporan mingguan KAK-P02** (*pelaporan proyek*).
- Perubahan ruang lingkup wajib melalui **CCB** (*Change Control Board* — badan pengendali perubahan) dan tidak boleh mengubah status uji secara diam-diam.
- Seluruh catatan bersifat tertulis agar jejak audit dapat diperiksa asesor.
