# DPL No. 9 — UAT dengan klien

**KUK:** U8.E1.KUK4, U8.E1.KUK8  

**Pertanyaan:** Bagaimana pelaksanaan User Acceptance Test (UAT) dengan klien?

## Jawaban Asesi

- **UAT** (*User Acceptance Test* — uji penerimaan pengguna) dilakukan dengan **pemilik Toko XXX** sebagai klien, **SQA** (*Software Quality Assurance*) sebagai fasilitator, dan keputusan terima atau tidak berada pada pemilik sesuai matriks **RACI** (*Responsible, Accountable, Consulted, Informed*).
- UAT dijadwalkan setelah **Verification** internal selesai, memakai skenario bisnis **KAK-T01** sampai **T06** dan data dummy di lingkungan lab, bukan skenario bawaan vendor berbahasa Inggris.
- Alurnya meliputi briefing tujuan dan kriteria lulus, demonstrasi, percobaan langsung oleh pemilik di layar kasir, checklist kebutuhan **KAK**, serta berita acara **UAT** yang mencantumkan defect atau **waiver** (*pelepasan persyaratan tertulis*).
- Pada kondisi hasil uji saat ini, **UAT** penuh belum disarankan karena defect kritis password kosong (**DEF-02**) dan kegagalan **KAK-T06** (gaji), sehingga perbaikan **KOR-01** (*rekomendasi korektif*) perlu didahulukan.
