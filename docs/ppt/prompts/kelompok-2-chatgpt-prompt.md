# Prompt PPT — Kelompok 2 (Hasil Pengujian)

Salin dari `---PROMPT---` sampai `---AKHIR PROMPT---`.

---PROMPT---

Kamu adalah desainer presentasi profesional untuk asesmen **Software Quality Assurance** skema **SS-LSP.UEU-002-2020**, tahap **4A Kelompok 2 — SQA Development** (verifikasi tahap pengembangan & hasil uji).

Buatkan **outline presentasi PowerPoint persis 5 slide** (bukan 4, bukan 6). Bahasa **Indonesia**. Target waktu **5 menit** (~1 menit per slide). Slide padat informasi tetapi **tidak penuh teks** — gunakan tabel ringkas dan angka nyata di bawah.

## Konteks (wajib konsisten, jangan diubah)

- **SUT:** uniCenta oPOS **5.0** (Linux, diekstrak dari .deb komunitas)
- **Dibandingkan dengan:** KAK Sistem Kasir POS — Toko XXX
- **Dokumen uji:** TR-XYZ-POS-001, pelaksanaan **21 Oktober 2026**
- **Lingkungan lab:** Ubuntu 24.04, MySQL 8.0 lokal port 3306, skema DB **`unicenta`**, data dummy kategori **Elektronik Toko XXX** (Headset/Keyboard/Mouse, dll.)
- **Pelaksana:** Mohammad Asrofil Nadhif (SQA)
- **Acuan rencana:** SQAP-XYZ-POS-001 (Kelompok 1)

## Ringkasan hasil uji (fakta — jangan dibuat optimis)

- **21 kasus uji** dieksekusi: **12 Pass**, **3 Sebagian**, **6 Fail**
- Teknik: fungsional black box (GUI + DB), integrasi POS↔MySQL, otomatis (`tests/run_sqa_tests.py` → `hasil-otomatis.json`), white box (properties + skema SQL), stress (BENCHMARK 10k baca stok ~125 ms), keamanan, deliverable/proses waterfall
- **Verifikasi tahap:** produk jadi **dapat diuji**, tetapi **jejak waterfall vendor tidak lengkap** (TC-P-01 Sebagian)

### Yang lulus (cuplikan untuk slide)

| Kebutuhan KAK | Bukti singkat |
| --- | --- |
| T01, S01 — POS menggantikan Excel | Aplikasi native start, JDBC OK, produk terbaca |
| T03 — transaksi di database | 52 tabel; tiket lab `RCPT-LAB-001` + `ticketlines` |
| T04 — stok real time | Headset **20 → 19** setelah 1 penjualan (kueri `stockcurrent`) |
| D01 — peran | Administrator, Manager, Employee, Guest |
| Integrasi / stress | Pembayaran cash 150.000 tersimpan; join stok < 500 ms |

### Yang gagal / sebagian (wajib ditampilkan jujur)

| ID / KAK | Temuan | Keparahan |
| --- | --- | --- |
| **T06** | Tidak ada modul/tabel **gaji/payroll** (hanya shift/leaves) — **DEF-01** | Mayor / wajib KAK |
| **K01, D01** | Semua user default **password NULL** — **DEF-02** | **Kritis** |
| **K01** | `db.password` **polos** di `unicentaopos.properties` — **DEF-03** | Mayor |
| **T05, S02** | Pemasukan dapat direkap; **pengeluaran operasional tidak lengkap** — DEF-04 | Sebagian / Mayor |
| **D02–D05** | Manual bergambar Toko XXX & **garansi 3 bulan** tidak ada — DEF-05/06 | Mayor |
| **W, P** | Dokumen waterfall P01–P03 tidak terbukti — DEF-07 | Sebagian |

**Keputusan gerbang Verification (SQAP):** **TIDAK LULUS rilis** — ada defect **kritis** + **T06 Fail**.

## Struktur 5 slide

**Slide 1 — Judul & ringkasan eksekutif**
- Judul: Hasil Pengujian Kualitas — uniCenta oPOS vs KAK Toko XXX
- Sub: Kelompok 2 · 5 menit
- Angka besar: 21 kasus · 12 Pass · 3 Sebagian · 6 Fail · 1 kritis terbuka
- Satu kalimat: uji mengacu SQAP; SUT bukan alat testing

**Slide 2 — Metode & cakupan uji**
- Diagram atau bullet: Black box GUI (kasir, stok, laporan) + White box (skema, config) + Integrasi JDBC + Otomatis Python + Stress + Keamanan
- Contoh ID kasus: TC-F-01 s.d. TC-D-03 (cukup sebut kategori, tidak perlu 21 baris)
- Bukti: screenshot GUI, kueri MySQL, JSON otomatis

**Slide 3 — Temuan positif (sesuai KAK)**
- Tabel 4–5 baris: T01, T03, T04, D01, kinerja/integrasi
- Sertakan contoh nyata stok 20→19 dan tiket lab

**Slide 4 — Temuan negatif & defect log**
- Tabel DEF-01 s.d. DEF-03 minimal (gaji, password NULL, DB password polos) + satu baris dokumentasi/garansi
- Highlight merah untuk **kritis** dan **T06**
- Kalimat penutup: **gerbang rilis tidak lulus**

**Slide 5 — Verifikasi tahap & tindak lanjut ke Kelompok 3**
- Status waterfall vendor: sebagian / tidak lengkap
- Apa yang sudah diverifikasi di lab (start app, jual barang, cek stok, skrip otomatis)
- Bridge 1 kalimat: rekomendasi korektif/preventif diserahkan ke **Kelompok 3** (jangan ulangi seluruh KOR di sini)

## Format output

Per slide: **Judul**, **Konten**, **Catatan pembicara** (45–60 detik), **Saran visual** (screenshot mock: layar kasir uniCenta, tabel matriks, ikon Pass/Fail).

Opsional di akhir (di luar 5 slide): 3 bullet “demo live ke asesor” (buka kategori Elektronik Toko XXX, jual 1 item, tunjukkan stok turun di MySQL).

Warna: header **#1F4E79**, teks Fail/kritis **#8B0000**.

**Larangan:** Jangan tulis T06 Pass, jangan hapus defect kritis, jangan klaim Selenium untuk GUI Swing.

---AKHIR PROMPT---
