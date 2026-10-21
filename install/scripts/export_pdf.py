#!/usr/bin/env python3
"""Convert assessment markdown/HTML to PDF via LibreOffice."""
from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
from pathlib import Path

import markdown

ROOT = Path(__file__).resolve().parents[2]
PDF = ROOT / "docs/pdf"
HTML_TMP = ROOT / "docs/pdf/_html"
CSS = """
body { font-family: Liberation Serif, serif; font-size: 11pt; line-height: 1.35; max-width: 180mm; margin: 16mm auto; color: #111; }
h1, h2, h3 { font-family: Liberation Sans, Arial, sans-serif; color: #1f4e79; }
table { border-collapse: collapse; width: 100%; font-size: 9.5pt; margin: 8px 0 16px; }
th, td { border: 1px solid #888; padding: 4px 6px; vertical-align: top; }
th { background: #e8eef4; }
code { font-size: 9pt; }
img { max-width: 100%; height: auto; display: block; margin: 10px 0 16px; page-break-inside: avoid; }
hr { border: none; border-top: 1px solid #ccc; margin: 18px 0; }
"""


def fix_md_images(content: str, md_path: Path) -> str:
    def sub(match: re.Match[str]) -> str:
        alt, path = match.group(1), match.group(2)
        if path.startswith(("http://", "https://", "data:")):
            return match.group(0)
        abs_p = (md_path.parent / path).resolve()
        rel = os.path.relpath(abs_p, HTML_TMP)
        return f"![{alt}]({rel})"

    return re.sub(r"!\[([^\]]*)\]\(([^)]+)\)", sub, content)


def md_to_html(src: Path, dst: Path) -> None:
    text = fix_md_images(src.read_text(encoding="utf-8"), src)
    body = markdown.markdown(text, extensions=["tables", "fenced_code"])
    dst.write_text(
        f"<!DOCTYPE html><html lang='id'><head><meta charset='utf-8'/><title>{src.stem}</title>"
        f"<style>{CSS}</style></head><body>{body}</body></html>",
        encoding="utf-8",
    )


def to_pdf(html: Path, outdir: Path) -> Path:
    subprocess.run(
        [
            "soffice",
            "--headless",
            "--norestore",
            "--convert-to",
            "pdf:writer_pdf_Export",
            "--outdir",
            str(outdir),
            str(html),
        ],
        check=True,
        capture_output=True,
    )
    return outdir / f"{html.stem}.pdf"


def export_md(src: Path, pdf_name: Path | None = None) -> Path:
    HTML_TMP.mkdir(parents=True, exist_ok=True)
    PDF.mkdir(parents=True, exist_ok=True)
    html = HTML_TMP / (src.stem + ".html")
    md_to_html(src, html)
    generated = to_pdf(html, PDF)
    if pdf_name:
        shutil.move(str(generated), str(pdf_name))
        return pdf_name
    return generated


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--single", type=Path, help="Satu berkas markdown → PDF")
    parser.add_argument("--out", type=Path, help="Nama/ path PDF keluaran (dengan --single)")
    args = parser.parse_args()

    if args.single:
        out = args.out or (PDF / f"{args.single.stem}.pdf")
        path = export_md(args.single.resolve(), out.resolve())
        print(f"PDF: {path} ({path.stat().st_size} bytes)")
        return

    PDF.mkdir(parents=True, exist_ok=True)
    HTML_TMP.mkdir(parents=True, exist_ok=True)

    md_files = [
        ROOT / "docs/kelompok-1/Rencana-Penjaminan-Kualitas-Software.md",
        ROOT / "docs/kelompok-1/RTM-Kebutuhan.md",
        ROOT / "docs/kelompok-2/Verifikasi-Tahap-Pengembangan.md",
        ROOT / "docs/kelompok-2/Skenario-Pengujian.md",
        ROOT / "docs/kelompok-2/Matriks-Hasil-Pengujian.md",
        ROOT / "docs/kelompok-2/Bukti-Uji-Manual-GUI.md",
        ROOT / "docs/kelompok-3/Rekomendasi-Penjaminan-Kualitas.md",
        ROOT / "install/CATATAN-INSTALASI.md",
    ]
    for src in md_files:
        export_md(src)

    for slide in sorted((ROOT / "docs/ppt").glob("*.html")):
        to_pdf(slide, PDF)

    print("PDF:")
    for p in sorted(PDF.glob("*.pdf")):
        print(f"  {p.name} {p.stat().st_size}")


if __name__ == "__main__":
    main()
