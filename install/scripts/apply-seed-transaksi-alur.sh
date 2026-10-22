#!/usr/bin/env bash
# Muat produk (jika perlu) + alur transaksi bisnis dummy ke skema uniCenta.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROP="${HOME}/unicentaopos.properties"
: "${MYSQL_USER:=asrofil}"
: "${MYSQL_PWD:=Asrofil123!}"
: "${MYSQL_HOST:=localhost}"

apply_one() {
  local db="$1"
  echo "==> Skema: ${db}"
  mysql -u "$MYSQL_USER" -p"$MYSQL_PWD" -h "$MYSQL_HOST" "$db" < "$ROOT/scripts/seed_toko_xxx.sql"
  mysql -u "$MYSQL_USER" -p"$MYSQL_PWD" -h "$MYSQL_HOST" "$db" < "$ROOT/scripts/seed_transaksi_alur_bisnis.sql"
  mysql -u "$MYSQL_USER" -p"$MYSQL_PWD" -h "$MYSQL_HOST" "$db" -e "
SELECT '--- closedcash ---' AS '';
SELECT money, datestart, dateend, nosales FROM closedcash WHERE money LIKE 'CASH%' ORDER BY datestart;
SELECT '--- penjualan hari ini ---' AS '';
SELECT r.id, r.datenew, t.customer, p.payment, p.total
FROM receipts r
JOIN payments p ON p.receipt = r.id
LEFT JOIN tickets t ON t.id = r.id
WHERE r.money = 'CASH-FLOW-20261021'
ORDER BY r.datenew;
SELECT '--- stok XXX ---' AS '';
SELECT pr.name, s.units FROM stockcurrent s
JOIN products pr ON pr.id = s.product WHERE pr.name LIKE '%XXX%' ORDER BY pr.name;
"
}

TARGET="${1:-unicenta}"
if [[ "$TARGET" == "all" ]]; then
  apply_one unicenta
  apply_one unicentaopos
elif [[ "$TARGET" == "unicenta" || "$TARGET" == "unicentaopos" ]]; then
  apply_one "$TARGET"
else
  DB="unicenta"
  if [[ -f "$PROP" ]]; then
    line="$(grep -E '^db\.schema=' "$PROP" | head -1 || true)"
    [[ -n "$line" ]] && DB="${line#db.schema=}"
  fi
  apply_one "$DB"
fi

echo "Selesai."
