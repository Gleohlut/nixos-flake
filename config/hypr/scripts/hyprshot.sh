#!/usr/bin/env bash
set -euo pipefail

mode="${1:-window}"

need() {
  command -v "$1" >/dev/null 2>&1 || {
    notify-send -u critical "Screenshot failed" "Missing dependency: $1"
    exit 1
  }
}

need grim
need wl-copy
need notify-send
need hyprctl

# Save location
base_dir="${XDG_PICTURES_DIR:-$HOME/Pictures}"
dir="$base_dir/Screenshots"
mkdir -p "$dir"

ts="$(date +'%Y-%m-%d_%H-%M-%S')"
file="$dir/${ts}_${mode}.png"

geo=""

case "$mode" in
  window)
    need jq
    geo="$(hyprctl activewindow -j 2>/dev/null | jq -r '
      if (.at and .size) then "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])" else "" end
    ' 2>/dev/null || true)"
    # Fallback if Hyprland reports nothing useful
    [[ -n "$geo" && "$geo" != "null,null nullxnull" && "$geo" != "0,0 0x0" ]] || mode="screen"
    ;;
  area)
    need slurp
    geo="$(slurp 2>/dev/null || true)"
    [[ -n "$geo" ]] || exit 0
    ;;
  screen|full)
    mode="screen"
    ;;
  *)
    notify-send -u low "Screenshot" "Usage: hyprshot {window|area|screen}"
    exit 2
    ;;
esac

# Capture -> save -> copy to clipboard
if [[ "$mode" == "screen" ]]; then
  grim - | tee "$file" | wl-copy --type image/png
else
  grim -g "$geo" - | tee "$file" | wl-copy --type image/png
fi

notify-send -u low -i "$file" "Screenshot saved" "$file"$'\n'"Copied to clipboard"
