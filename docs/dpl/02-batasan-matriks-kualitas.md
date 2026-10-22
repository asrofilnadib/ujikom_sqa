# DPL No. 2 — Batasan min/max matriks kualitas

**KUK:** U2.E4.KUK1, U2.E4.KUK2, U2.E4.KUK3  

**Pertanyaan:** Apa tujuannya menetapkan batasan maksimum atau minimum beserta toleransi nilai matriks kualitas?

## Jawaban Asesi

- Batas **minimum**, **maksimum**, dan **toleransi** membuat penilaian mutu **objektif** dan konsisten, sehingga keputusan rilis tidak bergantung pada penilaian subjektif penguji.
- **Minimum** adalah syarat lulus, misalnya seratus persen kasus wajib **KAK** dieksekusi dan nol **defect** (*cacat perangkat lunak*) berkeparahan kritis.
- **Maksimum** adalah batas kinerja yang masih diterima, misalnya waktu kueri stok di bawah lima ratus milidetik pada uji stress.
- **Toleransi** adalah deviasi yang masih diperbolehkan sebelum status berubah, misalnya stok harus turun tepat satu unit setelah satu penjualan diuji.
- Nilai tersebut diisi di **matriks hasil uji** TR-XYZ-POS-001 dengan kolom Expected, Actual, dan status Pass, Fail, atau Sebagian.
