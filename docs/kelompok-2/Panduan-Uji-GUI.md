# Panduan uji manual GUI — uniCenta vs KAK Toko XXX

**Database:** `unicenta` @ `localhost:3306`  
**Login:** Administrator (password kosong)  
**Acuan matriks:** `Matriks-Hasil-Pengujian.md` · **Skenario:** `Skenario-Pengujian.md`

Setiap langkah: lakukan di GUI → catat **Expected / Actual** → **screenshot** (nama file jelas, mis. `TC-F-02-tiket.png`).

---

## A. Persiapan (sekali)

1. Pastikan MySQL jalan: `systemctl status mysql` atau coba login `mysql -u asrofil -p`.
2. Jalankan POS: `unicenta-opos` (bukan Configuration saja).
3. Pilih **Administrator** → password **kosong** → OK.
4. Pastikan kategori **Elektronik Toko XXX** dan produk Headset / Keyboard / Mouse terlihat (seperti layar kasir kamu).

**Cek DB sebelum uji (baseline stok):**

```bash
mysql -u asrofil -p'Asrofil123!' -h localhost unicenta -e "
SELECT p.name, s.units FROM stockcurrent s
JOIN products p ON p.id=s.product
WHERE p.name LIKE '%XXX%';
"
```

Catat angka stok (mis. Headset **19**, Keyboard **15**, Mouse **30**).

---

## B. Uji fungsional (black box) — wajib untuk asesor

### TC-F-01 · Ganti Excel / POS jalan (KAK-T01, S01)

| Langkah | Yang kamu lihat |
| --- | --- |
| 1 | Aplikasi desktop uniCenta terbuka, bukan spreadsheet Excel |
| 2 | Ada grid tiket, keypad, tombol produk |

**Bukti:** screenshot layar kasir + catatan “aplikasi POS aktif”.

---

### TC-F-02 · Catat transaksi (KAK-T02, T03)

| Langkah | Yang kamu lakukan |
| --- | --- |
| 1 | Klik **Mouse Wireless XXX** (atau produk lain) sekali → baris muncul di tiket |
| 2 | Klik tombol **bayar** / payment (ikon keranjang / cash — sesuai toolbar POS kamu) |
| 3 | Pilih **Cash**, lunasi sesuai total, selesaikan tiket |

**Expected:** Tiket tersimpan, tidak perlu Excel.

**Bukti:** screenshot sebelum & sesudah bayar.

---

### TC-F-03 · Stok real time (KAK-T04)

| Langkah | Yang kamu lakukan |
| --- | --- |
| 1 | Catat stok Mouse **sebelum** jual (query SQL di atas) |
| 2 | Jual **1** Mouse lewat GUI (langkah TC-F-02) |
| 3 | Jalankan lagi query stok |

**Expected:** Stok Mouse turun 1 (mis. 30 → 29).

**Bukti:** screenshot GUI + output terminal query.

---

### TC-F-04 · Laporan pemasukan (KAK-T05, S02) — sebagian

| Langkah | Yang kamu lakukan |
| --- | --- |
| 1 | Buka **Menu** (ikon garis tiga) → cari **Reports** / **Payments** / **Closed cash** (nama bisa Inggris) |
| 2 | Buka laporan penjualan atau cash untuk **hari ini** |

**Expected:** Ada nilai penjualan hari ini setelah transaksi kamu.

**Catatan Fail/Sebagian:** laporan **pengeluaran** toko lengkap seperti KAK mungkin tidak ada → tulis di matriks “Sebagian”.

**Bukti:** screenshot laporan.

---

### TC-F-05 · Gaji karyawan (KAK-T06) — diharapkan Fail

| Langkah | Yang kamu lakukan |
| --- | --- |
| 1 | Di Menu, cari modul **Payroll / Salary / Gaji** |
| 2 | Jika tidak ada, cari di **Maintenance → People** apakah ada hitung gaji |

**Expected KAK:** bisa hitung gaji per karyawan.  
**Actual:** tidak ada modul gaji → **Fail** (ini temuan penting untuk Kelompok 3).

**Bukti:** screenshot menu (tidak ada payroll).

---

### TC-F-06 · Peran karyawan vs admin (KAK-D01)

| Langkah | Yang kamu lakukan |
| --- | --- |
| 1 | Logout (ikon keluar) |
| 2 | Login **Employee** (password kosong) |
| 3 | Coba buka Menu → Maintenance / Users / Settings |

**Expected:** Employee tidak punya hak sama dengan Administrator (menu terbatas atau tidak bisa ubah user).

**Bukti:** screenshot menu Administrator vs Employee.

---

## C. Uji keamanan (singkat, defensif)

### TC-S-02 / TC-S-03 · Password default

| Langkah | Hasil yang kamu catat |
| --- | --- |
| Login Administrator tanpa isi password | **Fail KAK** — password NULL |
| Query: `SELECT name, apppassword FROM people;` | Semua NULL |

**Bukti:** screenshot login + hasil query.

### TC-W-01 · Password DB di file

```bash
grep db.password ~/unicentaopos.properties
```

Jika terbaca polos → **Fail** (temuan keamanan).

---

## D. Uji otomatis (pelengkap, bukan ganti GUI)

Dari folder proyek:

```bash
cd ~/Project/personal/ujikom_sqa
python3 tests/run_sqa_tests.py
cat docs/kelompok-2/hasil-otomatis.json
```

Ini mengunci integritas DB (stok, pembayaran lab, skema). **Tetap tunjukkan uji GUI** ke asesor.

---

## E. Setelah selesai — isi matriks

1. Buka `docs/kelompok-2/Matriks-Hasil-Pengujian.md` (atau PDF di `Documents/ujikom_sqa`).
2. Untuk tiap TC yang kamu jalankan: perbarui **Actual** jika beda dari lab (mis. stok Mouse sekarang 29).
3. Lampirkan screenshot ke folder [`docs/bukti/J.62SQA00.008.1-manual/`](../bukti/J.62SQA00.008.1-manual/) (unit **J.62SQA00.008.1**).

---

## F. Ringkas untuk presentasi 5 menit (Kelompok 2)

1. POS jalan, produk Toko XXX (Pass T01).  
2. Transaksi + stok turun (Pass T03, T04).  
3. Laporan ada sebagian (T05 Sebagian).  
4. **Tidak ada gaji** (Fail T06).  
5. Password kosong (Fail kritis K01).
