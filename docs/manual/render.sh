#!/usr/bin/env bash
# Membuat ulang manual penggunaan MANDU 2.0 dalam bentuk PDF.
#
#   docs/manual/render.sh
#
# Sumber: manual-mandu.html + tangkapan layar di img/. Hasil: manual-mandu.pdf.
set -euo pipefail

cd "$(dirname "$0")"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

if [[ ! -x "$CHROME" ]]; then
  echo "Google Chrome tidak ditemukan di $CHROME" >&2
  exit 1
fi

missing=0
while read -r image; do
  [[ -f "$image" ]] || { echo "Gambar hilang: $image" >&2; missing=1; }
done < <(grep -o 'src="img/[^"]*"' manual-mandu.html | sed 's/src="//; s/"//' | sort -u)
[[ $missing -eq 0 ]] || echo "Lengkapi tangkapan layar yang hilang sebelum membagikan PDF." >&2

"$CHROME" --headless --disable-gpu --no-pdf-header-footer \
  --virtual-time-budget=10000 \
  --print-to-pdf="$PWD/manual-mandu.pdf" \
  manual-mandu.html 2>/dev/null

echo "PDF dibuat: $PWD/manual-mandu.pdf"
