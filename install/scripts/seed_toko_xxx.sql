-- Data dummy Toko XXX (lab SQA). Boleh dijalankan ulang (idempotent).
-- Target skema: unicenta (sesuai install/unicentaopos.properties)
SET NAMES utf8mb4;

-- Kategori lab tampil dulu di layar kasir (bukan "Category Standard")
INSERT INTO categories (id, name, catshowname, catorder) VALUES
  ('ELEC', 'Elektronik Toko XXX', 1, '0')
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  catshowname = 1,
  catorder = '0';

UPDATE categories SET catorder = '9' WHERE id = '000';

-- Produk
INSERT INTO products (id, reference, code, name, pricebuy, pricesell, category, taxcat, isservice, display, printto) VALUES
  ('P-HP-001', 'HP001', '8990000000011', 'Headset Bluetooth XXX', 75000, 125000, 'ELEC', '001', 0, '<html><center>Headset Bluetooth XXX', '1'),
  ('P-KB-001', 'KB001', '8990000000028', 'Keyboard USB XXX', 90000, 150000, 'ELEC', '001', 0, '<html><center>Keyboard USB XXX', '1'),
  ('P-MS-001', 'MS001', '8990000000035', 'Mouse Wireless XXX', 45000, 85000, 'ELEC', '001', 0, '<html><center>Mouse Wireless XXX', '1'),
  ('P-MN-001', 'MN001', '8990000000042', 'Monitor LED 24 XXX', 1200000, 1750000, 'ELEC', '001', 0, '<html><center>Monitor LED 24 XXX', '1'),
  ('P-HD-001', 'HD001', '8990000000059', 'Kabel HDMI 2m XXX', 25000, 45000, 'ELEC', '001', 0, '<html><center>Kabel HDMI 2m XXX', '1')
ON DUPLICATE KEY UPDATE
  reference = VALUES(reference),
  code = VALUES(code),
  name = VALUES(name),
  pricebuy = VALUES(pricebuy),
  pricesell = VALUES(pricesell),
  category = VALUES(category),
  taxcat = VALUES(taxcat),
  isservice = VALUES(isservice),
  display = VALUES(display),
  printto = VALUES(printto);

INSERT INTO products_cat (product, catorder) VALUES
  ('P-HP-001', 1),
  ('P-KB-001', 2),
  ('P-MS-001', 3),
  ('P-MN-001', 4),
  ('P-HD-001', 5)
ON DUPLICATE KEY UPDATE catorder = VALUES(catorder);

-- MySQL UNIQUE + NULL bisa duplikat; rapikan lalu set stok lab
DELETE FROM stockcurrent
WHERE product IN ('P-HP-001', 'P-KB-001', 'P-MS-001', 'P-MN-001', 'P-HD-001')
  AND attributesetinstance_id IS NULL;

INSERT INTO stockcurrent (location, product, attributesetinstance_id, units) VALUES
  ('0', 'P-HP-001', NULL, 25),
  ('0', 'P-KB-001', NULL, 15),
  ('0', 'P-MS-001', NULL, 30),
  ('0', 'P-MN-001', NULL, 8),
  ('0', 'P-HD-001', NULL, 50);

-- Pelanggan dummy (untuk uji assign customer di kasir, bukan data nyata)
INSERT INTO customers (id, searchkey, name, taxcategory, maxdebt, firstname, lastname, email, phone, visible) VALUES
  ('CUST-001', 'ASROFIL', 'Asrofil (Dummy Lab)', NULL, 500000, 'Asrofil', 'Nadhif', 'asrofil.lab@example.local', '081234567890', b'1'),
  ('CUST-002', 'WALKIN', 'Pelanggan Umum XXX', NULL, 0, 'Pelanggan', 'Umum', NULL, NULL, b'1'),
  ('CUST-003', 'KORP01', 'PT Contoh Toko XXX', NULL, 2000000, 'Budi', 'Santoso', 'budi@contoh-toko-xxx.local', '0215550101', b'1')
ON DUPLICATE KEY UPDATE
  searchkey = VALUES(searchkey),
  name = VALUES(name),
  firstname = VALUES(firstname),
  lastname = VALUES(lastname),
  email = VALUES(email),
  phone = VALUES(phone),
  visible = b'1';

-- Transaksi contoh (hapus dulu agar aman dijalankan ulang)
DELETE FROM payments WHERE receipt = 'RCPT-LAB-001';
DELETE FROM ticketlines WHERE ticket = 'RCPT-LAB-001';
DELETE FROM tickets WHERE id = 'RCPT-LAB-001';
DELETE FROM receipts WHERE id = 'RCPT-LAB-001';
DELETE FROM closedcash WHERE money = 'CASH-LAB-001';

INSERT INTO closedcash (money, host, hostsequence, datestart, dateend) VALUES
  ('CASH-LAB-001', 'ubuntu-lab', 1, '2026-10-21 09:00:00', NULL);

INSERT INTO receipts (id, money, datenew, person) VALUES
  ('RCPT-LAB-001', 'CASH-LAB-001', '2026-10-21 10:15:00', '0');

INSERT INTO tickets (id, tickettype, ticketid, person, status) VALUES
  ('RCPT-LAB-001', 0, 1, '0', 0);

INSERT INTO ticketlines (ticket, line, product, units, price, taxid) VALUES
  ('RCPT-LAB-001', 0, 'P-HP-001', 1, 125000, '001');

INSERT INTO payments (id, receipt, payment, total, tendered) VALUES
  ('PAY-LAB-001', 'RCPT-LAB-001', 'cash', 150000, 150000);

UPDATE ticketsnum SET id = GREATEST(id, 2);
