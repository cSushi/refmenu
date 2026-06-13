#!/usr/bin/env bash
# refmenu uninstaller
set -euo pipefail

BIN_DIR="${XDG_BIN_HOME:-$HOME/.local/bin}"
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/refmenu"

rm -f "$BIN_DIR/refmenu" && echo "removed $BIN_DIR/refmenu"
rm -rf "$DATA_DIR"        && echo "removed $DATA_DIR"
echo "refmenu uninstalled."
