#!/usr/bin/env bash

#  ╺┳╸┏━╸┏━┓┏┳┓
#   ┃ ┣╸ ┣┳┛┃┃┃
#   ╹ ┗━╸╹┗╸╹ ╹

# Enable strict mode.
set -euo pipefail

# Terminal should be opened in daemon mode by default, making it more performant.
single_instance=true

# Window class to set for terminal.
window_class="kitty"

while (($# > 0)) && [[ "$1" =~ ^- && ! "$1" == "--" ]]; do
  case "$1" in
    --class)
      shift
      if [[ -z "$1" ]]; then
        echo "Error: --class requires a value" >&2
        exit 1
      fi

      # Set window class.
      window_class="$1"
      ;;
    --detach)
      # Detach new terminal from the daemon.
      single_instance=false
      ;;
  esac

  # Shift past the processed options.
  shift
done

# Shift past the '--' argument if present
if (($# > 0)) && [[ "$1" == '--' ]]; then shift; fi

function execute_kitty() {
  local cmd=("kitty")

  [[ "${single_instance}" == true ]] && cmd+=("--single-instance")
  cmd+=("--class" "${window_class}")
  cmd+=("$@")
  "${cmd[@]}" &> /dev/null &
}

# Open terminal without arguments.
function open_terminal() {
  [[ "$1" -ne 0 ]] && return 1
  execute_kitty
  return 0
}

# Open terminal at specified path.
function open_path_in_terminal() {
  local target_path

  target_path=$(readlink -e "$1") || return 1
  [[ -f "${target_path}" ]] && target_path=$(dirname "${target_path}")
  execute_kitty --directory "${target_path}"
  return 0
}

# Open terminal and execute command.
function open_executable_in_terminal() {
  local executable="$1"
  local target_path

  shift
  target_path=$(readlink -e "$*" 2> /dev/null || echo "")

  if [[ -n "${target_path}" ]]; then
    execute_kitty -e zsh -ic "${executable} \"${target_path}\";zsh"
  else
    execute_kitty -e zsh -ic "${executable};zsh"
  fi
  return 0
}

open_terminal "$#" || open_path_in_terminal "$*" || open_executable_in_terminal "$@"
disown
