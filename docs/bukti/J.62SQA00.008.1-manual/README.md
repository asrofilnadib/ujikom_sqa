# Bukti uji manual GUI — uniCenta oPOS

**Unit kompetensi:** J.62SQA00.008.1  
**Kelompok 4A:** 2 (SQA Development)  
**Lampiran tertulis:** [Bukti-Uji-Manual-GUI.md](../../kelompok-2/Bukti-Uji-Manual-GUI.md)  
**PDF gabungan:** `docs/pdf/4.A Kel.2.pdf` (via `install/scripts/build-4a-kel2-pdf.sh`)

## GUI (screenshot)

| File | Kasus | Keterangan |
| --- | --- | --- |
| TC-F-01-pos-aktif-katalog-elektronik-toko-xxx.png | TC-F-01 | Layar kasir, kategori Elektronik Toko XXX, Administrator |
| TC-F-02-pencatatan-transaksi-tiket-kasir.png | TC-F-02 | Tiket multi-item + subtotal/tax/total |
| TC-F-06a-form-pelanggan-field-nama-terisi.png | TC-F-06 | Form customer: field **Name** terisi (Search Key wajib) |
| TC-F-06-form-pelanggan-peran-guest.png | TC-F-06 | Form customer, sesi **Guest** |

## Terminal / konfigurasi (render otomatis)

| File | Kasus |
| --- | --- |
| TC-F-03-stok-produk-xxx.png | TC-F-03 stok `stockcurrent` |
| TC-F-05-skema-tanpa-tabel-gaji.png | TC-F-05 Fail DEF-01 |
| TC-I-01-pembayaran-tiket-lab.png | TC-I-01 integrasi pembayaran |
| TC-S-02c-query-password-null.png | TC-S-02/03 DEF-02 |
| TC-W-01-db-password-properties.png | TC-W-01 DEF-03 |

Regenerasi PNG terminal:

```bash
~/Project/personal/ujikom_sqa/install/scripts/render-terminal-bukti.sh
```

## Opsional (ambil manual di GUI)

- `TC-S-02a-layar-login.png` — dialog login, password dikosongkan lalu OK  
- `TC-F-02c-dialog-pembayaran-cash.png` — dialog bayar tunai dengan field **tendered**  
- `TC-F-04-laporan-kas.png` — menu Reports / closed cash  
