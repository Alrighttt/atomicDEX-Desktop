#!/usr/bin/env bash
set -euo pipefail

# Builds the KDF WASM binary from the GPL-2.0 licensed source and copies
# it into the gleec-wallet project, bypassing the pre-built binary download
# from GLEECBTC's releases.
#
# Prerequisites:
#   - Rust stable toolchain
#   - wasm-pack (curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh)
#   - protoc (protobuf compiler)
#   - KDF source at $KDF_SRC (default: ~/repos/komodo-defi-framework)
#
# Usage:
#   ./scripts/build-kdf-wasm.sh                          # use default KDF path
#   KDF_SRC=/path/to/kdf ./scripts/build-kdf-wasm.sh     # custom KDF path

KDF_SRC="${KDF_SRC:-$HOME/repos/komodo-defi-framework}"
WALLET_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KDF_DEST="$WALLET_ROOT/sdk/packages/komodo_defi_framework/web/kdf/bin"

if [ ! -d "$KDF_SRC/mm2src" ]; then
    echo "ERROR: KDF source not found at $KDF_SRC"
    echo "Clone it:  git clone https://github.com/ComputerGenieCo/dex-framework.git -b GPL2 $KDF_SRC"
    exit 1
fi

cd "$KDF_SRC"

echo "==> Ensuring wasm32 target is installed..."
rustup target add wasm32-unknown-unknown

echo "==> Building KDF WASM (this takes 10-20 minutes)..."
wasm-pack build --release mm2src/mm2_bin_lib --target web --out-dir ../../target/target-wasm-release

BUILD_OUT="$KDF_SRC/target/target-wasm-release"

echo "==> Copying WASM artifacts to gleec-wallet..."
mkdir -p "$KDF_DEST"
cp "$BUILD_OUT/kdflib_bg.wasm" "$KDF_DEST/"
cp "$BUILD_OUT/kdflib.js" "$KDF_DEST/"

# Copy snippets if present
if [ -d "$BUILD_OUT/snippets" ]; then
    rm -rf "$KDF_DEST/../res/snippets"
    cp -r "$BUILD_OUT/snippets" "$KDF_DEST/../res/snippets" 2>/dev/null || true
fi

WASM_SIZE=$(ls -lh "$KDF_DEST/kdflib_bg.wasm" | awk '{print $5}')
COMMIT=$(cd "$KDF_SRC" && git rev-parse --short HEAD)
echo "==> Done. KDF WASM ($WASM_SIZE) from commit $COMMIT placed in:"
echo "    $KDF_DEST"
echo ""
echo "Now disable the auto-download in build_config.json:"
echo '    Set "fetch_at_build_enabled": false in api section'
echo ""
echo "Then build the wallet:  flutter build web --release --csp --no-web-resources-cdn"
