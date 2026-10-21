#!/usr/bin/env bash
# Muat ulang data dummy Toko XXX ke skema yang dipakai uniCenta (default: unicenta).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SQL="$ROOT/scripts/seed_toko_xxx.sql"
PROP="${HOME}/unicentaopos.properties"
DB="unicenta"

if [[ -f "$PROP" ]]; then
  schema_line="$(grep -E '^db\.schema=' "$PROP" | head -1 || true)"
  if [[ -n "$schema_line" ]]; then
    DB="${schema_line#db.schema=}"
  fi
fi

: "${MYSQL_USER:=asrofil}"
: "${MYSQL_PWD:=Asrofil123!}"
: "${MYSQL_HOST:=localhost}"

echo "Memuat seed Toko XXX ke skema: ${DB}"
mysql -u "$MYSQL_USER" -p"$MYSQL_PWD" -h "$MYSQL_HOST" "$DB" < "$SQL"

echo "Selesai. Ringkasan:"
mysql -u "$MYSQL_USER" -p"$MYSQL_PWD" -h "$MYSQL_HOST" "$DB" -e "
SELECT id, name, catorder FROM categories ORDER BY catorder;
SELECT id, name, pricesell FROM products WHERE category = 'ELEC';
SELECT searchkey, name FROM customers;
SELECT p.name, s.units FROM stockcurrent s JOIN products p ON p.id = s.product WHERE p.category = 'ELEC';
"
