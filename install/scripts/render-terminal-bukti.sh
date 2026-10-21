#!/usr/bin/env bash
# Render output perintah ke PNG (bukti uji manual pelengkap GUI).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT_DIR="$ROOT/docs/bukti/J.62SQA00.008.1-manual"
mkdir -p "$OUT_DIR"

: "${MYSQL_USER:=asrofil}"
: "${MYSQL_PWD:=Asrofil123!}"

python3 - "$OUT_DIR" <<'PY'
import subprocess
import sys
from datetime import datetime
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

out_dir = Path(sys.argv[1])
font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf", 14)
font_title = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", 15)

def render(name: str, title: str, cmd: list[str]) -> None:
    proc = subprocess.run(cmd, capture_output=True, text=True)
    body = (proc.stdout or "") + (proc.stderr or "")
    lines = [f"{title}", f"{datetime.now():%Y-%m-%d %H:%M:%S}", ""] + body.splitlines()
    line_h = 18
    pad = 16
    w = 920
    h = pad * 2 + line_h * max(len(lines), 4)
    img = Image.new("RGB", (w, h), "#1e1e1e")
    draw = ImageDraw.Draw(img)
    y = pad
    for i, line in enumerate(lines):
        f = font_title if i == 0 else font
        draw.text((pad, y), line[:110], fill="#e8e8e8", font=f)
        y += line_h
    path = out_dir / name
    img.save(path)
    print(f"Wrote {path}")

mysql_base = ["mysql", "-u", "asrofil", "-pAsrofil123!", "-h", "localhost", "unicenta", "-e"]

render(
    "TC-F-03-stok-produk-xxx.png",
    "TC-F-03 · stockcurrent (produk XXX)",
    mysql_base
    + [
        "SELECT p.name, s.units FROM stockcurrent s "
        "JOIN products p ON p.id=s.product "
        "WHERE p.name LIKE '%XXX%' ORDER BY p.name;"
    ],
)

render(
    "TC-S-02c-query-password-null.png",
    "TC-S-02 · people.apppassword (defect DEF-02)",
    mysql_base
    + ["SELECT name, apppassword IS NULL AS password_null FROM people ORDER BY name;"],
)

render(
    "TC-I-01-pembayaran-tiket-lab.png",
    "TC-I-01 · pembayaran tiket lab RCPT-LAB-001",
    mysql_base
    + [
        "SELECT r.id, p.payment, p.total FROM receipts r "
        "JOIN payments p ON p.receipt = r.id WHERE r.id = 'RCPT-LAB-001';"
    ],
)

render(
    "TC-F-05-skema-tanpa-tabel-gaji.png",
    "TC-F-05 · tidak ada tabel payroll/salary (DEF-01)",
    mysql_base
    + [
        "SHOW TABLES LIKE '%pay%'; SHOW TABLES LIKE '%salary%'; SHOW TABLES LIKE '%gaji%';"
    ],
)

props = Path.home() / "unicentaopos.properties"
prop_lines = [
    ln
    for ln in props.read_text(encoding="utf-8").splitlines()
    if ln.startswith(("db.password=", "db.user=", "db.schema="))
]
lines = ["TC-W-01 · ~/unicentaopos.properties (DEF-03)", f"{datetime.now():%Y-%m-%d %H:%M:%S}", ""] + prop_lines
line_h = 18
pad = 16
w = 920
h = pad * 2 + line_h * max(len(lines), 4)
img = Image.new("RGB", (w, h), "#1e1e1e")
draw = ImageDraw.Draw(img)
y = pad
for i, line in enumerate(lines):
    f = font_title if i == 0 else font
    draw.text((pad, y), line[:110], fill="#e8e8e8", font=f)
    y += line_h
path = out_dir / "TC-W-01-db-password-properties.png"
img.save(path)
print(f"Wrote {path}")
PY
