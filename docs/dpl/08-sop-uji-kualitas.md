# DPL No. 8 — Memastikan SOP uji kualitas berjalan

**KUK:** U8.E1.KUK1  

**Pertanyaan:** Bagaimana memastikan SOP pelaksanaan uji kualitas berjalan sesuai harapan dan standar yang ditetapkan?

## Jawaban Asesi

- **SOP** (*Standard Operating Procedure*) uji mengacu **ISO/IEC/IEEE 29119** dan **SQAP** (*Software Quality Assurance Plan*): rencana uji disetujui **PM**, setiap kasus memiliki langkah, expected, actual, dan bukti.
- Matriks diisi secara jujur; status Pass tidak boleh diberikan tanpa eksekusi nyata.
- Pemastian dilakukan melalui checklist fase **Verification**, review sampel oleh **PM**, dan pencocokan berkas **JSON** otomatis serta screenshot **GUI** (*Graphical User Interface*) dengan matriks.
- Urutan praktis di lab: smoke test aplikasi, menjalankan `run_sqa_tests.py`, uji manual kasir, pengisian defect, lalu penilaian **DoD** (*Definition of Done* — definisi selesai) pada gerbang rilis.
- Apabila kasus wajib **KAK** dilewati, ketidaksesuaian proses dicatat dan dilaporkan, bukan disembunyikan.
