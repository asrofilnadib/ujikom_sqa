# DPL No. 8 — Memastikan SOP uji kualitas berjalan

**KUK:** U8.E1.KUK1  

**Pertanyaan:** Bagaimana memastikan SOP pelaksanaan uji kualitas berjalan sesuai harapan dan standar yang ditetapkan?

## Jawaban Asesi

SOP uji mengacu ISO/IEC/IEEE 29119 dan SQAP: rencana uji (skenario) disetujui PM, setiap kasus dieksekusi dengan langkah, expected, actual, dan bukti, hasil dicatat di matriks dan defect log, lalu direview agar tidak ada Pass tanpa eksekusi. Memastikannya dengan checklist Verification, sampel review PM, membandingkan matriks dengan hasil otomatis dan screenshot GUI, serta walkthrough alur kasir; jika kasus wajib KAK dilewati, itu dicatat sebagai ketidaksesuaian proses. Pada proyek POS, urutannya smoke aplikasi, skrip `run_sqa_tests.py`, uji manual GUI, lalu keputusan gerbang sesuai Definition of Done SQAP.
