#!/usr/bin/env bash
set -euo pipefail

# Builds KDF WASM from GPL-2.0 source, builds the Flutter web app, and
# pushes build/web/ to the static-web branch.
#
# Usage:
#   ./scripts/deploy.sh                    # deploy to origin
#   ./scripts/deploy.sh my-fork            # deploy to a different remote
#
# Prerequisites:
#   - Flutter 3.41.4+ installed
#   - Rust stable toolchain + wasm-pack + protoc
#   - git submodules initialized (git submodule update --init --recursive)
#   - KDF source at $KDF_SRC (default: ~/repos/komodo-defi-framework)

REMOTE="${1:-origin}"
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$REPO_ROOT/build/web"
BRANCH="static-web"

cd "$REPO_ROOT"

echo "==> Building KDF WASM from source..."
"$REPO_ROOT/scripts/build-kdf-wasm.sh"

echo "==> Cleaning previous build..."
flutter clean
rm -rf build/*

echo "==> First build (generates coin assets)..."
flutter pub get || true
flutter build web --release --csp --no-web-resources-cdn || true
find build -mindepth 1 -maxdepth 1 ! -name 'native_assets' -exec rm -rf {} + 2>/dev/null || true

echo "==> Second build (assets registered in AssetManifest)..."
flutter pub get
flutter build web --release --csp --no-web-resources-cdn

echo "==> Copying Cloudflare/Pages config..."
cp web/_headers "$BUILD_DIR/_headers" 2>/dev/null || true
cp web/_redirects "$BUILD_DIR/_redirects" 2>/dev/null || true
cp "$BUILD_DIR/index.html" "$BUILD_DIR/404.html"

echo "==> Deploying to $REMOTE/$BRANCH..."
cd "$BUILD_DIR"
git init
git checkout -b "$BRANCH"
git add -A
git commit -m "deploy $(date -u '+%Y-%m-%d %H:%M UTC')"

REMOTE_URL=$(cd "$REPO_ROOT" && git remote get-url "$REMOTE")
git remote add origin "$REMOTE_URL"
git push -f origin "$BRANCH"

echo "==> Done. Site deployed to $BRANCH branch."
echo "    GitHub Pages: enable Pages -> Source -> Deploy from branch -> static-web"
echo "    Cloudflare Pages: point to static-web branch, build command: (leave empty)"
