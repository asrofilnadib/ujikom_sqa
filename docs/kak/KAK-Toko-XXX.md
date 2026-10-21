# Kerangka Acuan Kerja

**Sistem Kasir Point of Sales**  
Organisasi pengguna: Toko XXX, Jakarta  
Organisasi pengembang (asesmen): Organisasi XYZ  
Sumber dana: anggaran belanja Toko XXX sebesar Rp 25.000.000,-  
Jangka waktu: 45 hari kerja, terhitung Februari 20XX  
Metodologi pengembangan: Waterfall

Dokumen ini adalah transkrip kebutuhan dari KAK asesmen (bukan deliverable 4A). Rencana SQA, skenario uji, dan rekomendasi merujuk ID kebutuhan di bawah.

## 1. Latar belakang

Pada era digital, banyak perangkat elektronik dipakai untuk mempermudah aktivitas sehari-hari. Pencatatan transaksi yang dulu memakai buku, Microsoft Word, atau Excel tidak efisien: aplikasi office terus memakai banyak ruang dan memori, kapasitas memori yang dibutuhkan sangat besar, dan jika file terpisah maka pencatatan mudah meropotkan.

Toko XXX (toko elektronik, Jakarta) akan memakai aplikasi Point of Sales (POS) untuk:

- mempermudah pencatatan kegiatan transaksi;
- mengelola hasil transaksi;
- memperoleh laporan dari transaksi.

Aplikasi POS berupa **aplikasi berbasis desktop** dengan **sistem basis data** sebagai media penyimpanan.

## 2. Maksud dan tujuan (KAK-T)

| ID | Pernyataan kebutuhan |
| --- | --- |
| KAK-T01 | Memperbaharui sistem pencatatan transaksi barang Toko XXX dari Microsoft Excel menjadi aplikasi point of sale. |
| KAK-T02 | Mempermudah proses pencatatan kegiatan transaksi barang. |
| KAK-T03 | Tercatatnya kegiatan transaksi ke dalam sebuah database. |
| KAK-T04 | Mengetahui jumlah stok barang secara real time. |
| KAK-T05 | Memberikan hasil report pemasukan dan pengeluaran pada Toko XXX secara otomatis. |
| KAK-T06 | Mempermudah dalam menentukan jumlah gaji untuk setiap karyawan. |

## 3. Sasaran (KAK-S)

| ID | Sasaran |
| --- | --- |
| KAK-S01 | Tersedianya aplikasi yang digunakan Toko XXX untuk memudahkan pencatatan kegiatan transaksi barang. |
| KAK-S02 | Adanya laporan jumlah pemasukan dan pengeluaran Toko XXX setiap bulan. |

## 4. Lingkup kegiatan (KAK-L)

| ID | Kegiatan |
| --- | --- |
| KAK-L01 | Mengidentifikasi kebutuhan user dan kebutuhan sistem. |
| KAK-L02 | Menganalisis proses transaksi dan sistem penggajian karyawan. |
| KAK-L03 | Melakukan perancangan arsitektur aplikasi. |
| KAK-L04 | Membuat desain user interface aplikasi. |
| KAK-L05 | Testing aplikasi. |
| KAK-L06 | Pembuatan dokumentasi. |
| KAK-L07 | Deploy aplikasi ke komputer client. |

Lokasi pengerjaan: tempat developer aplikasi.  
Fasilitas: database milik Toko XXX.

## 5. Alih pengetahuan (KAK-A)

| ID | Keluaran pengetahuan |
| --- | --- |
| KAK-A01 | Dokumentasi lengkap, jelas, dan mudah dimengerti untuk aplikasi POS. |
| KAK-A02 | Quick guide untuk pemilik Toko XXX. |

## 6. Karakteristik waterfall (KAK-W)

| ID | Aturan proses |
| --- | --- |
| KAK-W01 | Linear production flow: setiap fase diselesaikan dahulu sebelum fase berikutnya. |
| KAK-W02 | Development phases do not overlap. |
| KAK-W03 | Development plans never change: rencana tidak berubah setelah suatu fase selesai. |

Fase: Requirements → Design → Implementation → Verification → Maintenance.

## 7. Kualifikasi pengembang (KAK-K)

| ID | Kualifikasi |
| --- | --- |
| KAK-K01 | Bersedia tidak menyebarkan data rahasia perusahaan. |
| KAK-K02 | Berkomitmen bertanggung jawab terhadap pekerjaan. |
| KAK-K03 | Sanggup memberi garansi atas berfungsinya aplikasi secara sempurna selama 3 bulan sejak serah terima. |

## 8. Tenaga ahli (KAK-R)

| Peran | Tanggung jawab KAK |
| --- | --- |
| Project manager | Rencana pelaksanaan, analisis dan evaluasi, solusi tepat guna, konsep dasar sistem, memimpin pelaksanaan. |
| System designer | Merancang sistem, mengoordinasikan uji coba operasional, penyusunan dokumentasi sistem, pelatihan calon pengguna. |
| Programmer | Membangun program aplikasi. |

## 9. Keluaran proyek (KAK-D)

| ID | Deliverable |
| --- | --- |
| KAK-D01 | Aplikasi POS yang dapat dioperasikan oleh karyawan dan admin. |
| KAK-D02 | Dokumentasi kegiatan yang dilaksanakan selama proses pembuatan aplikasi. |
| KAK-D03 | Dokumentasi seluruh sistem dan perangkat lunak dalam bentuk user manual. |
| KAK-D04 | Petunjuk penggunaan aplikasi dengan menggunakan gambar. |
| KAK-D05 | Garansi dan pemeliharaan selama 3 bulan. |

## 10. Pelaporan (KAK-P)

| ID | Laporan |
| --- | --- |
| KAK-P01 | Laporan pendahuluan: rencana kerja, jadwal, estimasi batas waktu. |
| KAK-P02 | Laporan mingguan: hasil pengerjaan dalam minggu tersebut. |
| KAK-P03 | Laporan akhir: keluaran proyek. |

## 11. Perangkat lunak yang diuji pada asesmen

Organisasi XYZ menyerahkan **uniCenta oPOS** (desktop Java, basis data MySQL/MariaDB) sebagai implementasi POS untuk Toko XXX. SQA menguji kesesuaian produk itu terhadap kebutuhan di atas, bukan mengembangkan POS baru.
