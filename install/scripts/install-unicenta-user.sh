#!/usr/bin/env bash
# Pasang uniCenta oPOS ke profil user (tanpa sudo). Untuk paket sistem: sudo dpkg -i install/downloads/unicenta-opos_5.0-1_amd64-1.deb
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REPO="$(cd "$ROOT/.." && pwd)"
DEB="$REPO/install/downloads/unicenta-opos_5.0-1_amd64-1.deb"
EXTRACT="$REPO/install/unicenta/opt/unicenta-opos"
BIN="$EXTRACT/bin/unicenta-opos"
PROP_SRC="$REPO/install/unicentaopos.properties"

if [[ ! -x "$BIN" ]]; then
  if [[ -f "$DEB" ]]; then
    echo "Mengekstrak paket .deb ke $REPO/install/unicenta ..."
    mkdir -p "$REPO/install/unicenta"
    dpkg-deb -x "$DEB" "$REPO/install/unicenta"
  else
    echo "Tidak ditemukan: $BIN atau $DEB" >&2
    exit 1
  fi
fi

mkdir -p "$HOME/.local/bin" "$HOME/.local/share/applications"
WRAPPER="$HOME/.local/bin/unicenta-opos"
cat > "$WRAPPER" <<EOF
#!/usr/bin/env bash
set -euo pipefail
cp -a "$PROP_SRC" "\$HOME/unicentaopos.properties"
exec "$BIN" "\$@"
EOF
chmod +x "$WRAPPER"

ICON="$EXTRACT/lib/app/unicentaopos.png"
DESK="$HOME/.local/share/applications/unicenta-opos.desktop"
cat > "$DESK" <<EOF
[Desktop Entry]
Type=Application
Name=uniCenta oPOS
Comment=Point of Sale Toko XXX (lab SQA)
Exec=$WRAPPER
Icon=$ICON
Terminal=false
Categories=Office;
EOF

cp -a "$PROP_SRC" "$HOME/unicentaopos.properties"

echo "Selesai."
echo "  Perintah: unicenta-opos   (pastikan ~/.local/bin ada di PATH)"
echo "  Atau:     $REPO/install/scripts/start-unicenta.sh"
echo ""
echo "Instalasi sistem (/opt): sudo dpkg -i $DEB"
echo "Setelah dpkg, sesuaikan db.driverlib ke /opt/unicenta-opos/lib/app/lib/mariadb-java-client-2.7.0.jar"
