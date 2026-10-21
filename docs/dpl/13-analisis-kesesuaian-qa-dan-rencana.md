# DPL No. 13 — Analisis kesesuaian & objektivitas QA dengan rencana

**KUK:** U12.E1.KUK1, U12.E1.KUK2  

**Pertanyaan:** Bagaimana menganalisis kesesuaian pelaksanaan dan objektivitas Quality Assurance (QA) dengan rencana?

## Jawaban Asesi

Analisis dilakukan dengan membandingkan SQAP dan RTM (rencana) terhadap matriks, defect log, dan bukti uji per ID KAK: apa yang direncanakan diuji harus terlihat dieksekusi dengan status jujur. Objektivitas QA terjaga jika SQA independen, Pass/Fail hanya berdasarkan bukti, dan temuan buruk tetap dilaporkan—pada proyek POS, T01/T03/T04 sesuai rencana, tetapi T06 gagal, DEF-02 kritis melanggar Definition of Done, sehingga gerbang Verification tidak lulus sesuai SQAP, bukan melawan rencana. Jika tidak sesuai, saya keluarkan KOR/PRE, eskalasi ke PM dan pemilik, dan tidak merekomendasikan rilis tanpa perbaikan atau waiver tertulis.
