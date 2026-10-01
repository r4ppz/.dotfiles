#!/usr/bin/env bash
set -euo pipefail

LOCKFILE="/tmp/screenshot.lock"
readonly LOCKFILE
TIMESTAMP="$(date +%Y-%m-%d_%H-%M-%S)"
readonly TIMESTAMP

mode="region"
tmp_mode=false
copy=false

usage() {
  cat <<EOF
Usage: $(basename "$0") [--region|--full] [--tmp] [--copy] [--help]
  --region, -r       Capture user-selected region (default)
  --full, -f         Capture fullscreen
  --tmp, -t          Save to /tmp (temporary, clears on reboot)
  --copy             Copy image to clipboard
  --help, -h         Show this help
EOF
}

die() {
  printf '%s\n' "$*" >&2
  exit 1
}

notify() {
  local title="$1" body="$2" icon="${3:-camera}" timeout="${4:-1400}"
  notify-send -h boolean:transient:true "$title" "$body" -i "$icon" -t "$timeout"
}

require_cmds() {
  local cmd
  for cmd in "$@"; do
    command -v "$cmd" &>/dev/null || die "Missing required command: $cmd"
  done
}

capture() {
  local file="$1" region="${2:-}"
  if [[ $copy == true ]]; then
    if [[ -n $region ]]; then
      grim -g "$region" - | tee "$file" | (
        exec 200>&-
        wl-copy --type image/png
      )
    else
      grim - | tee "$file" | (
        exec 200>&-
        wl-copy --type image/png
      )
    fi
  else
    if [[ -n $region ]]; then
      grim -g "$region" "$file"
    else
      grim "$file"
    fi
  fi
}

handle_result() {
  local file="$1" region="${2:-}"
  local title body

  if [[ ! -s $file ]]; then
    notify "Screenshot Failed" "Could not save the screenshot." dialog-error
    exit 1
  fi

  if [[ $tmp_mode == true ]]; then
    title="Screenshot Taken (Temporary)"
    body="Saved to: $file (clears on reboot)"
    [[ $copy == true ]] && body="Copied to clipboard — $file (clears on reboot)"
  else
    title="Screenshot Taken"
    body="Saved to: $file"
    [[ $copy == true ]] && body="Saved to: $file (copied to clipboard)"
    [[ $mode == full ]] && body="Full screen saved to: $file" && [[ $copy == true ]] && body+=" (copied to clipboard)"
  fi

  [[ -n $region ]] && body+="\nRegion: $region"
  body+="\nClick to open — Show in folder also available"

  # clickable: default action opens file, second opens folder (swaync supports -A)
  local action=""
  action="$(notify-send -h boolean:transient:true -A "default=Open" -A "folder=Show in folder" \
    "$title" "$body" -i camera -t 5000 -w 2>/dev/null || true)"
  case "$action" in
  default) xdg-open "$file" &>/dev/null & ;;
  folder) xdg-open "$(dirname "$file")" &>/dev/null & ;;
  esac
  exit 0
}

# --- parse args ---
for arg in "$@"; do
  case "$arg" in
  --region | -r) mode="region" ;;
  --full | -f | --fullscreen) mode="full" ;;
  --tmp | -t | --temp | --temporary) tmp_mode=true ;;
  --copy) copy=true ;;
  --help | -h)
    usage
    exit 0
    ;;
  *) die "Unknown argument: $arg" ;;
  esac
done

# --- single instance ---
exec 200>"$LOCKFILE"
flock -n 200 || {
  notify "Screenshot Already Running" "Please wait for the current process to finish." dialog-warning
  exit 1
}

# --- resolve output path ---
if [[ $tmp_mode == true ]]; then
  filename=""
  filename="$(mktemp "/tmp/screenshot_${TIMESTAMP}_XXXXXX.png")"
else
  dir="$HOME/Pictures/screenshot"
  mkdir -p "$dir"
  filename="$dir/screenshot_${TIMESTAMP}.png"
fi

# --- check deps ---
if [[ $mode == region ]]; then
  if [[ $copy == true ]]; then
    require_cmds grim slurp notify-send wl-copy
  else require_cmds grim slurp notify-send; fi
else
  if [[ $copy == true ]]; then
    require_cmds grim notify-send wl-copy
  else require_cmds grim notify-send; fi
fi

# --- capture ---
if [[ $mode == full ]]; then
  capture "$filename"
  exec 200>&-
  handle_result "$filename"
fi

region=""
region="$(slurp || true)"
[[ -z $region ]] && {
  notify "Screenshot Canceled" "No region selected." dialog-warning
  exit 1
}

sleep 0.2
capture "$filename" "$region"
exec 200>&-
handle_result "$filename" "$region"
