#!/usr/bin/env bash

#  ╻┏┓╻┏━┓╺┳╸┏━┓╻  ╻
#  ┃┃┗┫┗━┓ ┃ ┣━┫┃  ┃
#  ╹╹ ╹┗━┛ ╹ ╹ ╹┗━╸┗━╸

set -euo pipefail

readonly user_home="/home/${SUDO_USER:-${USER}}"
readonly bin_dir="${user_home}/.bin"
readonly local_bin="/usr/local/bin"

if [[ ! -w "${local_bin}" ]]; then
  echo "Error: Cannot write to ${local_bin}. Run with sudo." >&2
  exit 1
fi

for src in "${bin_dir}"/*.sh; do
  [[ -f "${src}" ]] || continue
  cmd="$(basename "${src%.sh}")"
  [[ "${cmd}" == "install" ]] && continue
  ln -sf "${src}" "${local_bin}/${cmd}"
done
