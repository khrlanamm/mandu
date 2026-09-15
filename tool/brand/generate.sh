#!/usr/bin/env bash
# Membuat semua aset brand MANDU dari SVG sumber di design/logo.
# Butuh: rsvg-convert (brew install librsvg) dan ImageMagick 7 (brew install imagemagick).
# Jalankan dari root repo: tool/brand/generate.sh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
LOGO="$ROOT/design/logo"
RES="$ROOT/android/app/src/main/res"
WEB="$ROOT/web"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

COLOR="$LOGO/mandu-symbol.svg"
ON_DARK="$LOGO/mandu-symbol-on-dark.svg"
MONO="$LOGO/mandu-symbol-mono.svg"

# compose <kanvas_px> <simbol_px> <latar|none> <svg> <output> [none|circle|rounded]
compose() {
  local size=$1 sym=$2 bg=$3 svg=$4 out=$5 shape=${6:-none}
  rsvg-convert -w "$sym" -h "$sym" "$svg" -o "$TMP/symbol.png"
  mkdir -p "$(dirname "$out")"
  case "$shape" in
    none)
      magick -size "${size}x${size}" "xc:$bg" "$TMP/symbol.png" -gravity center -composite "$out" ;;
    circle)
      magick -size "${size}x${size}" xc:none -fill "$bg" \
        -draw "circle $((size / 2)),$((size / 2)) $((size / 2)),0" \
        "$TMP/symbol.png" -gravity center -composite "$out" ;;
    rounded)
      local r=$((size * 22 / 100))
      magick -size "${size}x${size}" xc:none -fill "$bg" \
        -draw "roundrectangle 0,0 $((size - 1)),$((size - 1)) $r,$r" \
        "$TMP/symbol.png" -gravity center -composite "$out" ;;
  esac
}

# Siluet putih dengan alpha (ikon status bar / notifikasi).
white_silhouette() {
  local size=$1 out=$2
  rsvg-convert -w "$size" -h "$size" "$MONO" -o "$TMP/mono.png"
  mkdir -p "$(dirname "$out")"
  magick "$TMP/mono.png" -fill "#FFFFFF" -colorize 100 "$out"
}

echo "Android: launcher, adaptive icon, monochrome, notifikasi, splash"
# Hapus aset MANDU lama agar tidak bentrok nama resource.
rm -f "$RES"/mipmap-*/ic_launcher*.webp "$RES/drawable/app_logo.png" \
  "$RES/drawable/app_logo_scaled.xml" "$RES/drawable/ic_launcher_background.xml" \
  "$RES/drawable/ic_stat_notification.xml"

# density  launcher(48dp)  adaptive(108dp)  status(24dp)  splash(240dp)
while read -r density launcher adaptive status splash; do
  compose "$launcher" $((launcher * 70 / 100)) "#FFFFFF" "$COLOR" "$RES/mipmap-$density/ic_launcher.png" rounded
  compose "$launcher" $((launcher * 64 / 100)) "#FFFFFF" "$COLOR" "$RES/mipmap-$density/ic_launcher_round.png" circle
  # Simbol 60dp di kanvas 108dp: tetap di dalam zona aman 66dp.
  compose "$adaptive" $((adaptive * 60 / 108)) none "$COLOR" "$RES/mipmap-$density/ic_launcher_foreground.png"
  compose "$adaptive" $((adaptive * 60 / 108)) none "$MONO" "$RES/mipmap-$density/ic_launcher_monochrome.png"
  white_silhouette "$status" "$RES/drawable-$density/ic_stat_mandu.png"
  # Android 12+: ikon 240dp, isi harus muat di lingkaran 160dp.
  compose "$splash" $((splash * 46 / 100)) none "$COLOR" "$RES/drawable-$density/splash_icon.png"
  # Sebelum Android 12: lingkaran putih 160dp di atas latar navy.
  compose $((splash * 2 / 3)) $((splash * 46 / 100)) "#FFFFFF" "$COLOR" "$RES/drawable-$density/splash_legacy.png" circle
done <<'EOF'
mdpi 48 108 24 240
hdpi 72 162 36 360
xhdpi 96 216 48 480
xxhdpi 144 324 72 720
xxxhdpi 192 432 96 960
EOF

echo "Web: favicon, ikon PWA"
compose 32 32 none "$COLOR" "$WEB/favicon.png"
compose 192 134 "#FFFFFF" "$COLOR" "$WEB/icons/Icon-192.png" rounded
compose 512 358 "#FFFFFF" "$COLOR" "$WEB/icons/Icon-512.png" rounded
# Maskable: latar penuh, simbol di dalam zona aman 80%.
compose 192 110 "#FFFFFF" "$COLOR" "$WEB/icons/Icon-maskable-192.png"
compose 512 294 "#FFFFFF" "$COLOR" "$WEB/icons/Icon-maskable-512.png"

echo "Aset aplikasi"
mkdir -p "$ROOT/assets/brand"
cp "$COLOR" "$ROOT/assets/brand/mandu_symbol.svg"
cp "$ON_DARK" "$ROOT/assets/brand/mandu_symbol_on_dark.svg"

echo "Selesai."
