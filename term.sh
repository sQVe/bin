#!/usr/bin/env bash

#  ╺┳╸┏━╸┏━┓┏┳┓
#   ┃ ┣╸ ┣┳┛┃┃┃
#   ╹ ┗━╸╹┗╸╹ ╹

single_instance="--single-instance"

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do
  case $1 in
    -d | --detach)
      shift
      single_instance=""
      ;;
    -i | --instance)
      shift
      instance=(--class "$1")
      ;;
    -t | --title)
      shift
      title=(--title "$1")
      ;;
  esac
  shift
done
if [[ "$1" == '--' ]]; then shift; fi

# Simply open terminal if given no arguments.
function openTerminal() {
  if [[ $# -ne 0 ]]; then
    return 1
  fi

  kitty "${single_instance}" "${instance[@]}" "${title[@]}" &> /dev/null &
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

  kitty "${single_instance}" --directory "${path}" &> /dev/null &
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
    # Safely open path in executable. The quoting is needed to handle paths with spaces.
    kitty "${single_instance}" "${instance[@]}" "${title[@]}" -e zsh -ic "$executable \"$path\";zsh" &> /dev/null &
  else
    kitty "${single_instance}" "${instance[@]}" "${title[@]}" -e zsh -ic "$executable $*;zsh" &> /dev/null &
  fi

}

openTerminal "$#" || openPathInTerminal "$*" || openExecutableInTerminal "$@"
disown
