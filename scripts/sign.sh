#!/usr/bin/env bash
# Align and sign the release APK.
# With the KEYSTORE_B64 / KEYSTORE_PASS / KEY_ALIAS secrets the same key is used every build,
# so new versions install over old ones and keep the app data. Without them a throwaway key is made.
set -euo pipefail
BT=$(ls -d "$ANDROID_HOME"/build-tools/* | sort -V | tail -1)
UNSIGNED=$(ls android/app/build/outputs/apk/release/*.apk | head -1)
if [ -n "${KEYSTORE_B64:-}" ]; then
  echo "$KEYSTORE_B64" | base64 -d > ks.jks
  PASS="$KEYSTORE_PASS"; ALIAS="${KEY_ALIAS:-atwallet}"
else
  echo "No signing secrets found: using a throwaway key. Uninstall the old app before installing this one."
  PASS=atwallet-temp; ALIAS=atwallet
  keytool -genkeypair -keystore ks.jks -storepass "$PASS" -keypass "$PASS" -alias "$ALIAS" \
    -keyalg RSA -keysize 2048 -validity 10000 -dname "CN=AT wallet"
fi
"$BT/zipalign" -p -f 4 "$UNSIGNED" aligned.apk
"$BT/apksigner" sign --ks ks.jks --ks-pass "pass:$PASS" --key-pass "pass:$PASS" \
  --ks-key-alias "$ALIAS" --out AT-wallet.apk aligned.apk
"$BT/apksigner" verify AT-wallet.apk
