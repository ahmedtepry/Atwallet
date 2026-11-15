#!/usr/bin/env bash
# Replace the default launcher icons with the AT wallet icon.
set -euo pipefail
RES=android/app/src/main/res
rm -rf "$RES"/mipmap-anydpi-v26
for pair in mdpi:48 hdpi:72 xhdpi:96 xxhdpi:144 xxxhdpi:192; do
  d="${pair%%:*}"; px="${pair##*:}"
  mkdir -p "$RES/mipmap-$d"
  for name in ic_launcher ic_launcher_round ic_launcher_foreground; do
    convert web/icon-512.png -resize "${px}x${px}" "$RES/mipmap-$d/$name.png"
  done
done
