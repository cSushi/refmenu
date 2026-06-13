#!/usr/bin/env bash
# refmenu installer
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BIN_DIR="${XDG_BIN_HOME:-$HOME/.local/bin}"
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/refmenu/data"

echo "Installing refmenu..."

# 1. binary
mkdir -p "$BIN_DIR"
install -m 0755 "$REPO_DIR/bin/refmenu" "$BIN_DIR/refmenu"
echo "  bin  -> $BIN_DIR/refmenu"

# 2. data
mkdir -p "$DATA_DIR"
cp -f "$REPO_DIR"/data/*.cmds "$DATA_DIR"/
echo "  data -> $DATA_DIR/ ($(ls "$REPO_DIR"/data/*.cmds | wc -l) files)"

# 3. PATH check
case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) echo
     echo "  NOTE: $BIN_DIR is not in your PATH."
     echo "  Add this to your shell config (fish shown for you):"
     echo "    fish_add_path $BIN_DIR" ;;
esac

# 4. dependency check
command -v wofi >/dev/null 2>&1 || \
  echo "  NOTE: wofi not found. Install it:  sudo pacman -S wofi"

cat <<EOF

Done. Run it with:   refmenu

Suggest a Hyprland keybind (add to ~/.config/hypr/hyprland.conf):
    bind = \$mainMod, K, exec, refmenu

Add your own command sets by dropping <tool>.cmds files in:
    $DATA_DIR
EOF
