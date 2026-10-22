-- Alur bisnis dummy Toko XXX (lab SQA) — inject ke skema uniCenta.
-- Prasyarat: jalankan seed_toko_xxx.sql (produk, pelanggan, stok awal).
-- Idempotent untuk ID prefix FLOW / CASH-FLOW-*.
SET NAMES utf8mb4;

-- ---------------------------------------------------------------------------
-- 0. Bersihkan run sebelumnya (sesi demo satu hari)
-- ---------------------------------------------------------------------------
DELETE FROM payments WHERE receipt IN ('RCPT-FLOW-001', 'RCPT-FLOW-002', 'RCPT-FLOW-003');
DELETE FROM taxlines WHERE receipt IN ('RCPT-FLOW-001', 'RCPT-FLOW-002', 'RCPT-FLOW-003');
DELETE FROM ticketlines WHERE ticket IN ('RCPT-FLOW-001', 'RCPT-FLOW-002', 'RCPT-FLOW-003');
DELETE FROM tickets WHERE id IN ('RCPT-FLOW-001', 'RCPT-FLOW-002', 'RCPT-FLOW-003');
DELETE FROM receipts WHERE id IN ('RCPT-FLOW-001', 'RCPT-FLOW-002', 'RCPT-FLOW-003');
DELETE FROM stockdiary WHERE id LIKE 'SD-FLOW-%';
DELETE FROM closedcash WHERE money = 'CASH-FLOW-20261021';

-- ---------------------------------------------------------------------------
-- 1. Buka kasir (awal hari operasional)
-- ---------------------------------------------------------------------------
INSERT INTO closedcash (money, host, hostsequence, datestart, dateend, nosales) VALUES
  ('CASH-FLOW-20261021', 'ubuntu-lab', 3, '2026-10-21 08:00:00', NULL, 0);

-- ---------------------------------------------------------------------------
-- 2. Transaksi 1 — pelanggan umum: 1× Mouse, tunai
--    Harga jual eks. pajak 20% (taxid 001)
-- ---------------------------------------------------------------------------
INSERT INTO receipts (id, money, datenew, person) VALUES
  ('RCPT-FLOW-001', 'CASH-FLOW-20261021', '2026-10-21 09:15:00', '0');

INSERT INTO tickets (id, tickettype, ticketid, person, customer, status) VALUES
  ('RCPT-FLOW-001', 0, 10, '0', 'CUST-002', 0);

INSERT INTO ticketlines (ticket, line, product, units, price, taxid) VALUES
  ('RCPT-FLOW-001', 0, 'P-MS-001', 1, 85000, '001');

INSERT INTO payments (id, receipt, payment, total, tendered) VALUES
  ('PAY-FLOW-001', 'RCPT-FLOW-001', 'cash', 102000, 110000);

INSERT INTO taxlines (id, receipt, taxid, base, amount) VALUES
  ('TAX-FLOW-001', 'RCPT-FLOW-001', '001', 85000, 17000);

INSERT INTO stockdiary (id, datenew, reason, location, product, units, price, appuser) VALUES
  ('SD-FLOW-001', '2026-10-21 09:15:00', -1, '0', 'P-MS-001', -1, 85000, '0');

-- ---------------------------------------------------------------------------
-- 3. Transaksi 2 — pelanggan ASROFIL: Headset + Kabel HDMI
-- ---------------------------------------------------------------------------
INSERT INTO receipts (id, money, datenew, person) VALUES
  ('RCPT-FLOW-002', 'CASH-FLOW-20261021', '2026-10-21 11:30:00', '0');

INSERT INTO tickets (id, tickettype, ticketid, person, customer, status) VALUES
  ('RCPT-FLOW-002', 0, 11, '0', 'CUST-001', 0);

INSERT INTO ticketlines (ticket, line, product, units, price, taxid) VALUES
  ('RCPT-FLOW-002', 0, 'P-HP-001', 1, 125000, '001'),
  ('RCPT-FLOW-002', 1, 'P-HD-001', 1, 45000, '001');

INSERT INTO payments (id, receipt, payment, total, tendered) VALUES
  ('PAY-FLOW-002', 'RCPT-FLOW-002', 'cash', 204000, 204000);

INSERT INTO taxlines (id, receipt, taxid, base, amount) VALUES
  ('TAX-FLOW-002', 'RCPT-FLOW-002', '001', 170000, 34000);

INSERT INTO stockdiary (id, datenew, reason, location, product, units, price, appuser) VALUES
  ('SD-FLOW-002', '2026-10-21 11:30:00', -1, '0', 'P-HP-001', -1, 125000, '0'),
  ('SD-FLOW-003', '2026-10-21 11:30:00', -1, '0', 'P-HD-001', -1, 45000, '0');

-- ---------------------------------------------------------------------------
-- 4. Transaksi 3 — PT Contoh: 2× Keyboard (karyawan Employee)
-- ---------------------------------------------------------------------------
INSERT INTO receipts (id, money, datenew, person) VALUES
  ('RCPT-FLOW-003', 'CASH-FLOW-20261021', '2026-10-21 16:45:00', '2');

INSERT INTO tickets (id, tickettype, ticketid, person, customer, status) VALUES
  ('RCPT-FLOW-003', 0, 12, '2', 'CUST-003', 0);

INSERT INTO ticketlines (ticket, line, product, units, price, taxid) VALUES
  ('RCPT-FLOW-003', 0, 'P-KB-001', 2, 150000, '001');

INSERT INTO payments (id, receipt, payment, total, tendered) VALUES
  ('PAY-FLOW-003', 'RCPT-FLOW-003', 'cash', 360000, 360000);

INSERT INTO taxlines (id, receipt, taxid, base, amount) VALUES
  ('TAX-FLOW-003', 'RCPT-FLOW-003', '001', 300000, 60000);

INSERT INTO stockdiary (id, datenew, reason, location, product, units, price, appuser) VALUES
  ('SD-FLOW-004', '2026-10-21 16:45:00', -1, '0', 'P-KB-001', -2, 150000, '2');

-- ---------------------------------------------------------------------------
-- 5. Stok akhir (sesuai penjualan di atas, dari baseline seed)
--    Mouse -1, Headset -1, HDMI -1, Keyboard -2
-- ---------------------------------------------------------------------------
DELETE FROM stockcurrent
WHERE product IN ('P-MS-001', 'P-HP-001', 'P-HD-001', 'P-KB-001')
  AND attributesetinstance_id IS NULL;

INSERT INTO stockcurrent (location, product, attributesetinstance_id, units) VALUES
  ('0', 'P-MS-001', NULL, 29),
  ('0', 'P-HP-001', NULL, 24),
  ('0', 'P-HD-001', NULL, 49),
  ('0', 'P-KB-001', NULL, 13);

DELETE FROM stockcurrent
WHERE product = 'P-MN-001' AND attributesetinstance_id IS NULL;

INSERT INTO stockcurrent (location, product, attributesetinstance_id, units) VALUES
  ('0', 'P-MN-001', NULL, 8);

-- ---------------------------------------------------------------------------
-- 6. Tutup kasir (akhir hari)
-- ---------------------------------------------------------------------------
UPDATE closedcash SET
  dateend = '2026-10-21 18:00:00',
  nosales = 3
WHERE money = 'CASH-FLOW-20261021';

UPDATE ticketsnum SET id = GREATEST(id, 13);
