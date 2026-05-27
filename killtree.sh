#!/usr/bin/env bash

# ╻┏ ╻╻  ╻  ╺┳╸┏━┓┏━╸┏━╸
# ┣┻┓┃┃  ┃   ┃ ┣┳┛┣╸ ┣╸
# ╹ ╹╹┗━╸┗━╸ ╹ ╹┗╸┗━╸┗━╸
# Kill a process and every transitive descendant.

set -euo pipefail

readonly default_signal="TERM"

usage() {
  cat >&2 << EOF
Usage: ${0##*/} PID [SIGNAL]
       ... | ${0##*/} [SIGNAL]

Send SIGNAL to PID(s) and every descendant. Freezes each parent before
enumerating children, so nothing forks away mid-walk.

PIDs come from stdin when piped, or from the first argument.
SIGNAL defaults to TERM. Common: TERM, KILL, INT, HUP.

Examples:
  ${0##*/} 12345                             # graceful (SIGTERM)
  ${0##*/} 12345 KILL                        # force kill
  pgrep -of "pnpm run dev" | ${0##*/} KILL   # find and kill
EOF
  exit 2
}

kill_recursive() {
  local pid=$1
  local sig=$2

  # Freeze parent to close the fork race.
  kill -STOP "${pid}" 2> /dev/null || return 0

  local child
  for child in $(pgrep -P "${pid}" 2> /dev/null || true); do
    kill_recursive "${child}" "${sig}"
  done

  kill -s "${sig}" "${pid}" 2> /dev/null || true

  # Most signals need the process running to be acted on.
  case "${sig}" in
    KILL | 9 | STOP | 17 | 19 | 23) ;;
    *) kill -CONT "${pid}" 2> /dev/null || true ;;
  esac
}

main() {
  local sig raw_sig line pid
  local -a pids=()

  # Explicit numeric PID arg wins over stdin (so `killtree PID` works from cron too).
  if [[ $# -ge 1 && "${1}" =~ ^[0-9]+$ ]]; then
    [[ $# -le 2 ]] || usage
    pids=("${1}")
    raw_sig="${2:-${default_signal}}"
  elif [[ ! -t 0 ]]; then
    [[ $# -le 1 ]] || usage
    while IFS= read -r line; do
      [[ "${line}" =~ ^[0-9]+$ ]] && pids+=("${line}")
    done
    raw_sig="${1:-${default_signal}}"
  else
    usage
  fi

  [[ ${#pids[@]} -gt 0 ]] || {
    echo "${0##*/}: no PIDs provided" >&2
    exit 1
  }

  sig="${raw_sig#SIG}"
  sig="${sig^^}"

  # Reject anything that isn't a bare name or number — defeats `kill -1` fan-out.
  [[ "${sig}" =~ ^([A-Z]+|[0-9]+)$ ]] || {
    echo "${0##*/}: invalid signal: ${raw_sig}" >&2
    exit 2
  }

  # Reject unknown signal names so we don't STOP+CONT a tree without killing it.
  kill -l "${sig}" > /dev/null 2>&1 || {
    echo "${0##*/}: unknown signal: ${raw_sig}" >&2
    exit 2
  }

  for pid in "${pids[@]}"; do
    if ! kill -0 "${pid}" 2> /dev/null; then
      echo "${0##*/}: no process with PID ${pid}" >&2
      continue
    fi
    kill_recursive "${pid}" "${sig}"
  done
}

main "$@"
