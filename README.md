# Gleec Wallet & DEX

[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

<a href="https://dex.gleec.com" target="_blank">![web_app](https://github.com/GLEECBTC/gleec-wallet-archive/assets/10762374/ca06f4bc-2e7a-40c6-9e06-e0872a32cbdf)</a>

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/GLEECBTC/gleec-wallet?quickstart=1)

### Runs on:

- Web
- Desktop
  - Windows
  - MacOS
  - Linux
- Mobile
  - Android
  - iOS

---

## Web Deployment

The web wallet is deployed automatically via GitHub Actions to GitHub Pages
at [alrighttt.github.io/atomicDEX-Desktop](https://alrighttt.github.io/atomicDEX-Desktop).
Pushes to `main` trigger a build and deploy. See
`.github/workflows/github-pages.yml` for details.

## Self-host the web wallet

A pre-built static site is available on the `static-web` branch. No Flutter
install or build step required — just clone and serve.

### Run locally

```bash
# Clone only the static-web branch (small, no source code)
git clone --single-branch --branch static-web https://github.com/GLEECBTC/gleec-wallet.git gleec-wallet-web
cd gleec-wallet-web

# Serve locally (pick one)
python3 -m http.server 8080
# or
npx serve -s . -l 8080
```

Then open http://localhost:8080.

### Host on Cloudflare Pages or GitHub Pages

1. Fork this repo (or push to your own)
2. Point your hosting provider at the `static-web` branch
3. Set build command to **(leave empty)** — the branch already contains the built site
4. Set output directory to `/` (the branch root is the site root)

Cloudflare Pages is recommended because it supports custom response headers
(`_headers` file) needed for the WASM build. GitHub Pages works too but
requires the non-WASM fallback build.

### Rebuild the static site

To rebuild the `static-web` branch from source:

```bash
git clone --recurse-submodules https://github.com/GLEECBTC/gleec-wallet.git
cd gleec-wallet
./scripts/deploy.sh
```

This requires Flutter 3.41.4+. The script builds the web app and
force-pushes `build/web/` to the `static-web` branch.

---

## Developer guide.

### Index

- [Code of Conduct](docs/CODE_OF_CONDUCT.md)
- [Project setup](docs/PROJECT_SETUP.md)
- [Firebase Setup](docs/FIREBASE_SETUP.md)
- [Coins config, update](docs/COINS_CONFIG.md)
- [App version, update](docs/UPDATE_APP_VERSION.md)
- [Run the App](docs/BUILD_RUN_APP.md)
- [Build release version of the App](docs/BUILD_RELEASE.md)
- [Manual testing and debugging](docs/MANUAL_TESTING_DEBUGGING.md)
- [Localization](docs/LOCALIZATION.md)
- [Unit testing](docs/UNIT_TESTING.md)
- [Integration testing](docs/INTEGRATION_TESTING.md)
- [SDK Dependency Management](docs/SDK_DEPENDENCY_MANAGEMENT.md)
- [Gitflow and branching strategy](docs/GITFLOW_BRANCHING.md)
- [Issue: create and maintain](docs/ISSUE.md) ...in progress
- [Contribution guide](docs/CONTRIBUTION_GUIDE.md)
