# Catatan instalasi uniCenta oPOS — lingkungan uji Toko XXX

**Tanggal:** 21 Oktober 2026  
**Host:** Ubuntu 24.04.4 LTS (x86_64)  
**Tujuan:** perangkat lunak yang diuji (Kelompok 2), bukan alat testing.

## 1. Sumber paket

Halaman [uniCenta Installers](https://unicenta.com/download-files/installers/) menampilkan **uniCenta oPos 5.5.1 | Linux 64 bit | Native Installer**, tetapi unduhan itu **hanya untuk pelanggan berbayar** (“available to uniCenta Customer Base, Plus, Hosted…”).

Rilis komunitas yang dapat diunduh tanpa langganan, sesuai halaman SourceForge proyek yang sama:

- Berkas: `unicenta-opos_5.0-1_amd64-1.deb` (192 MB)
- Sumber: https://sourceforge.net/projects/unicentaopos/files/releases/linux/
- Versi aplikasi: **5.0** (native Linux, runtime Java bundled)

Installer diekstrak ke `install/unicenta/` tanpa `dpkg -i` (tidak mengubah paket sistem).

## 2. Prasyarat yang terpenuhi

| Komponen | Status lab |
| --- | --- |
| OpenJDK 8 | Ada (`1.8.0_492`), dipakai skrip JDBC uji |
| Runtime aplikasi | Bundled di `bin/unicenta-opos` (Java 11 in-app) |
| Basis data | MySQL **8.0.46** lokal di host, port **3306** |
| User DB | `asrofil` @ localhost |
| Skema | `unicenta` (default lab; salinan data dari setup awal) |

## 3. Basis data uji

MySQL server Ubuntu (bukan Docker). Skema dibuat ulang dengan user lokal:

```
mysql -u asrofil -h 127.0.0.1 -e "CREATE DATABASE unicentaopos CHARACTER SET utf8mb4;"
python3 install/scripts/expand_and_load_schema.py /tmp/unicenta-create-expanded.sql
mysql -u asrofil -h 127.0.0.1 unicentaopos < /tmp/unicenta-create-expanded.sql
mysql -u asrofil -h 127.0.0.1 unicentaopos < install/scripts/seed_toko_xxx.sql
./install/scripts/apply-seed-transaksi-alur.sh all   # produk + 3 transaksi + tutup kasir
```

Skema: skrip resmi `MySQL-create.sql` dengan placeholder `$FILE{}` diekspansi oleh `install/scripts/expand_and_load_schema.py`.  
Data dummy: `install/scripts/seed_toko_xxx.sql`.

## 4. Konfigurasi aplikasi

Berkas `~/unicentaopos.properties` (disalin dari `install/unicentaopos.properties` saat start):

- `db.URL=jdbc:mariadb://127.0.0.1:3306/unicentaopos` (server tetap MySQL 8.0 lokal; connector 5.1 tidak bisa handshake MySQL 8)
- `db.user=asrofil`
- `db.password` tersimpan **polos** (temuan keamanan TC-W-01)

Jalankan:

```
./install/scripts/start-unicenta.sh
```

Pengguna bawaan (password NULL / kosong): Administrator, Manager, Employee, Guest.

## 5. Data dummy Toko XXX

| Produk | Stok awal | Stok setelah transaksi lab |
| --- | --- | --- |
| Headset Bluetooth XXX | 20 | 19 |
| Keyboard USB XXX | 15 | 15 |
| Mouse Wireless XXX | 30 | 30 |

Transaksi lab: 1 headset, tunai 150.000 (harga 125.000 + pajak standar 20%).

## 6. Menyalakan ulang lab

```
sudo systemctl start mysql   # jika server belum jalan
./install/scripts/start-unicenta.sh
```
