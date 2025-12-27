#!/usr/bin/env bash

# ┏━╸╻ ╻┏━╸
# ┃╺┓┣━┫┃
# ┗━┛╹ ╹┗━╸
# GitHub clone.

set -euo pipefail

extract_field() {
  command cut -d '/' -f "$1" <<< "$2"
}

is_url() {
  grep -qE '^https?://' <<< "$1"
}

has_slash() {
  grep -q '/' <<< "$1"
}

if [[ $# -eq 1 ]]; then
  input="${1%.git}"
  input="${input%/}"

  if is_url "$input"; then
    identifier=$(extract_field 4-5 "$input")
  elif has_slash "$input"; then
    identifier="$input"
  else
    identifier="sQVe/$input"
  fi

  name=$(extract_field 1 "$identifier")
  repository=$(extract_field 2 "$identifier")
elif [[ $# -eq 2 ]]; then
  name="$1"
  repository="$2"
else
  echo "Usage: ghc <url|user/repo|repo> or ghc <user> <repo>" >&2
  exit 1
fi

git clone "git@github.com:${name}/${repository}.git"
