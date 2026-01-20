#!/usr/bin/env bash
set -euo pipefail

mode="${1:-window}"

PATH="/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH"

dir="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
mkdir -p "$dir"

ts="$(date +'%Y-%m-%d_%H-%M-%S')"
file="$dir/${ts}_${mode}.png"

fail() {
  notify-send -a "screenshot" "Screenshot failed" "$1"
  exit 1
}

need() { command -v "$1" >/dev/null 2>&1 || fail "Missing command: $1"; }

need grim
need slurp
need notify-send
need hyprctl

notify_ok() {
  notify-send -a "screenshot" -i "$file" "Screenshot saved" "$(basename "$file")"$'\n'"$file"
}

get_active_window_geom() {
  # expects lines like:
  # at: 123,456
  # size: 789,1011
  hyprctl activewindow 2>/dev/null | awk -F': ' '
    $1=="at"   {gsub(",", "", $2); at=$2}
    $1=="size" {gsub(",", "", $2); sz=$2}
    END { if (at=="" || sz=="") exit 1; print at " " sz }
  '
}

get_focused_monitor() {
  # expects blocks like:
  # Monitor eDP-1 (ID 0):
  #  ...
  #  focused: yes
  hyprctl monitors 2>/dev/null | awk '
    $1=="Monitor" {name=$2; sub(/:$/, "", name)}
    $1=="focused:" && $2=="yes" {print name; exit}
  '
}

case "$mode" in
  window)
    geom="$(get_active_window_geom)" || fail "Could not read active window geometry (hyprctl activewindow)"
    grim -g "$geom" "$file" || fail "grim failed (window)"
    notify_ok
    ;;
  monitor)
    mon="$(get_focused_monitor)" || true
    if [ -n "${mon:-}" ]; then
      grim -o "$mon" "$file" || fail "grim failed (monitor: $mon)"
    else
      # fallback: capture all outputs if focused monitor detection fails
      grim "$file" || fail "grim failed (all outputs fallback)"
    fi
    notify_ok
    ;;
  area)
    region="$(slurp)" || fail "slurp cancelled"
    grim -g "$region" "$file" || fail "grim failed (area)"
    notify_ok
    ;;
  *)
    fail "Usage: $0 {window|monitor|area}"
    ;;
esac
