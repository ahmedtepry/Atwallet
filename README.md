# AT wallet

Personal wallet for UAE dirham, Egyptian pound and 24k gold (grams). The app is the single source of truth for what you own.

- PIN lock (6 digits) with fingerprint / Face ID.
- Balances hidden until revealed; locks when you leave the app.
- Wallets in AED, EGP and gold grams; income, expense, transfers, currency exchange, gold buy/sell.
- Gold price in UAE (AED per gram) and Egypt (EGP per gram), exchange rate, and a "everything in EGP" view.
- Data stays on your device. Use Settings > backup to copy it.

Prices in the app are saved values. Update them from Settings.

## Run it

**Web app (installable):** Settings > Pages > Source: *GitHub Actions*. The `Deploy web app` workflow publishes `web/` to
`https://ahmedtepry.github.io/Atwallet/`. Open it on Android in Chrome and choose *Add to Home screen*.

**Android APK:** run the `Build APK` workflow (Actions tab > Build APK > Run workflow). When it finishes, open the repository's
*Releases* page on your phone and download `AT-wallet.apk`.

### Keep your data across APK updates

Without secrets, every build is signed with a new throwaway key, so Android makes you uninstall the old app first and the app data is lost.
Back up from Settings first, or add a permanent key once:

```bash
keytool -genkeypair -keystore at.jks -alias atwallet -keyalg RSA -keysize 2048 -validity 10000
base64 -w0 at.jks   # paste as the KEYSTORE_B64 secret
```

Add the repository secrets `KEYSTORE_B64`, `KEYSTORE_PASS` and `KEY_ALIAS` (Settings > Secrets and variables > Actions).
Never commit the keystore file.

## Layout

- `web/` the app (single HTML file, manifest, service worker, icons)
- `capacitor.config.json`, `package.json` Android wrapper (Capacitor with native biometric prompt)
- `scripts/` icon and signing helpers used by the workflows
