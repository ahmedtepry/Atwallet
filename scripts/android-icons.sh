#!/usr/bin/env bash
# Replace the default launcher icons with the pre-rendered AT wallet icons in scripts/icons.
set -euo pipefail
RES=android/app/src/main/res
rm -rf "$RES"/mipmap-anydpi-v26
cp -r scripts/icons/mipmap-* "$RES"/
