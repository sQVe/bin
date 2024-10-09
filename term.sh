#!/usr/bin/env bash

#  ╺┳╸┏━╸┏━┓┏┳┓
#   ┃ ┣╸ ┣┳┛┃┃┃
#   ╹ ┗━╸╹┗╸╹ ╹

# Terminal should be opened in daemon mode by default, making it more performant.
single_instance=true

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do
  case "$1" in
    --detach)
      # Detach new terminal from the daemon.
      single_instance=false
      ;;
  esac

  # Shift past the processed options
  shift
done

# Shift past the '--' argument if present
if [[ "$1" == '--' ]]; then shift; fi

# Simply open terminal if given no arguments.
function openTerminal() {
  if [[ "$1" -ne 0 ]]; then
    return 1
  fi

  if [[ "${single_instance}" = true ]]; then
    kitty --single-instance &> /dev/null &
  else
    kitty &> /dev/null &
  fi
}

# Open terminal at given path.
function openPathInTerminal() {
  local path

  # Ensure absolute path.
  path=$(readlink -e "$1")

  if [[ -z "${path}" ]]; then
    return 1
  fi

  # Get directory name if given file path.
  if [[ -f ${path} ]]; then
    path=$(dirname "${path}")
  fi

  if [[ "${single_instance}" = true ]]; then
    kitty --single-instance --directory "${path}" &> /dev/null &
  else
    kitty --directory "${path}" &> /dev/null &
  fi
}

# Open terminal and run given executable with options.
function openExecutableInTerminal() {
  local executable
  local path

  executable="$1"
  shift

  # Ensure absolute path
  path=$(readlink -e "$*")

  if [[ -n "${path}" ]]; then
    if [[ "${single_instance}" = true ]]; then
      kitty --single-instance -e zsh -ic "${executable} \"${path}\";zsh" &> /dev/null &
    else
      kitty -e zsh -ic "${executable} \"${path}\";zsh" &> /dev/null &
    fi
  else
    if [[ "${single_instance}" = true ]]; then
      kitty --single-instance -e zsh -ic "${executable};zsh" &> /dev/null &
    else
      kitty -e zsh -ic "${executable};zsh" &> /dev/null &
    fi
  fi
}

openTerminal "$#" || openPathInTerminal "$*" || openExecutableInTerminal "$@"
disown
