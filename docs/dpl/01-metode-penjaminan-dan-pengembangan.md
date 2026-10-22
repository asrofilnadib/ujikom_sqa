# DPL No. 1 — Metode penjaminan vs metode pengembangan

**KUK:** U1.E2.KUK1, U1.E2.KUK2  

**Pertanyaan:** Apa saja metode penjaminan kualitas proses dan produk pengembangan perangkat lunak, dan bagaimana menentukan kesesuaiannya dengan metode pengembangan?

## Jawaban Asesi

- Untuk **proses**, saya memakai **IEEE 730** (*IEEE Standard for Software Quality Assurance Processes* — standar proses penjaminan kualitas perangkat lunak), **ISO/IEC 12207** (*Software Life Cycle Processes* — proses siklus hidup perangkat lunak), dan **gerbang mutu** di tiap fase **waterfall** (alur pengembangan berurutan tanpa tumpang tindih).
- Untuk **produk dan pengujian**, saya memakai **ISO/IEC 25010** (*Systems and Software Quality Models* — model karakteristik mutu) serta **ISO/IEC/IEEE 29119** (seri standar pengujian perangkat lunak), dengan teknik black box, integrasi, keamanan, manual, dan otomatis ringan.
- **SQA** (*Software Quality Assurance* — penjaminan kualitas perangkat lunak) **tidak mengganti** metode pengembangan di **KAK** (*Kerangka Acuan Kerja*), melainkan menempelkan review dan **exit criteria** (syarat keluar fase) setelah Requirements, Design, Implementation, Verification, dan Maintenance.
- **Kesesuaian** dinilai jika tiap fase punya aktivitas QA yang setara, **RTM** (*Requirements Traceability Matrix* — matriks ketertelusuran kebutuhan) menghubungkan KAK ke kasus uji, dan hasil Verification dapat dibandingkan ke **SQAP** (*Software Quality Assurance Plan* — rencana penjaminan kualitas), seperti pada proyek **uniCenta oPOS** dengan dokumen SQAP-XYZ-POS-001.
