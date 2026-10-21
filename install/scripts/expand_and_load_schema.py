#!/usr/bin/env python3
"""Expand uniCenta $FILE{} placeholders and emit MySQL-ready SQL."""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1] / "unicenta/opt/unicenta-opos/lib/app/classes"
SRC = ROOT / "com/unicenta/pos/scripts/MySQL-create.sql"

APP_ID = "unicentaopos"
APP_NAME = "uniCenta oPOS"
APP_VERSION = "5.0"


def sql_bytes(data: bytes) -> str:
    return "x'" + data.hex() + "'"


def sql_str(text: str) -> str:
    return "'" + text.replace("\\", "\\\\").replace("'", "''") + "'"


def resolve_file(rel: str) -> bytes:
    rel = rel.lstrip("/")
    path = ROOT / rel
    if not path.exists():
        # some scripts live under reports as well
        alt = ROOT.parent / "reports" / rel
        path = alt if alt.exists() else path
    if not path.exists():
        raise FileNotFoundError(rel)
    return path.read_bytes()


def expand(sql: str) -> str:
    sql = sql.replace("$APP_ID{}", sql_str(APP_ID))
    sql = sql.replace("$APP_NAME{}", sql_str(APP_NAME))
    sql = sql.replace("$APP_VERSION{}", sql_str(APP_VERSION))

    def repl(match: re.Match[str]) -> str:
        rel = match.group(1)
        data = resolve_file(rel)
        # XML/text resources still stored as blob
        return sql_bytes(data)

    return re.sub(r"\$FILE\{([^}]+)\}", repl, sql)


def main() -> int:
    out = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("/dev/stdout")
    sql = expand(SRC.read_text(encoding="utf-8", errors="replace"))
    out.write_text(sql, encoding="utf-8")
    print(f"wrote {out} ({out.stat().st_size} bytes)", file=sys.stderr)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
