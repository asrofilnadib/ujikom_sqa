# DPL No. 13 — Analisis kesesuaian & objektivitas QA dengan rencana

**KUK:** U12.E1.KUK1, U12.E1.KUK2

**Pertanyaan:** Bagaimana menganalisis kesesuaian pelaksanaan dan objektivitas Quality Assurance (QA) dengan rencana?

## Jawaban Asesi

- Analisis dilakukan dengan membandingkan **SQAP** (*Software Quality Assurance Plan*) dan **RTM** (*Requirements Traceability Matrix*) sebagai rencana, terhadap matriks hasil, **defect log**, dan bukti uji per ID **KAK** (*Kerangka Acuan Kerja*).
- Pelaksanaan disebut sesuai rencana apabila kebutuhan yang direncanakan diuji, teknik uji di **SQAP** benar-benar dijalankan, dan status Pass atau Fail mencerminkan bukti, contohnya **KAK-T01**, **T03**, dan **T04** lulus sesuai matriks.
- Pelaksanaan disebut tidak sesuai apabila kebutuhan wajib gagal, seperti **KAK-T06** (gaji), **DEF-02** (password kritis), atau deliverable dokumentasi **KAK-D** yang tidak ada, meskipun aplikasi dapat dibuka.
- **Objektivitas QA** (*Quality Assurance*) terjaga ketika peran **SQA** independen, temuan buruk tetap dilaporkan, dan gerbang **Verification** dinyatakan tidak lulus sesuai **DoD** (*Definition of Done*), bukan dipaksakan lulus karena waktu habis.
- Jika tidak sesuai, saya mengeluarkan **KOR** dan **PRE**, melakukan eskalasi ke **PM** dan pemilik, dan tidak merekomendasikan rilis penuh tanpa perbaikan atau **waiver** tertulis.

