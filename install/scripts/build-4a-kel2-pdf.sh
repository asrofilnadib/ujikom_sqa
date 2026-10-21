#!/usr/bin/env bash
# Gabungkan dokumen Kelompok 2 + bukti GUI → PDF asesmen (4.A Kel.2.pdf).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
K2="$ROOT/docs/kelompok-2"
COMBINED="$K2/_4A-Kelompok-2-gabungan.md"
PDF_OUT="$ROOT/docs/pdf/4.A Kel.2.pdf"

parts=(
  "$K2/Verifikasi-Tahap-Pengembangan.md"
  "$K2/Skenario-Pengujian.md"
  "$K2/Matriks-Hasil-Pengujian.md"
  "$K2/Bukti-Uji-Manual-GUI.md"
)

{
  echo "# 4A — Kelompok 2: SQA Development"
  echo ""
  echo "**Proyek:** Sistem Kasir POS Toko XXX · **SUT:** uniCenta oPOS 5.0"
  echo ""
  echo "**Tanggal:** 21 Oktober 2026"
  echo ""
  for f in "${parts[@]}"; do
    echo ""
    echo "---"
    echo ""
    cat "$f"
  done
} > "$COMBINED"

python3 "$ROOT/install/scripts/export_pdf.py" --single "$COMBINED" --out "$PDF_OUT"
echo "PDF: $PDF_OUT"
