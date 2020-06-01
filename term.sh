#!/usr/bin/env bash

#  ╺┳╸┏━╸┏━┓┏┳┓
#   ┃ ┣╸ ┣┳┛┃┃┃
#   ╹ ┗━╸╹┗╸╹ ╹

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do
  case $1 in
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
  [[ $1 -ne 0 ]] && return 1

  alacritty "${instance[@]}" "${title[@]}" &>/dev/null &
}

# Open terminal at given path.
function openPathInTerminal() {
  local path

  # Ensure absolute path
  path=$(readlink -e "$1")

  [[ -z "$path" ]] && return 1
  # Get directory name if given file path.
  if [[ -f $path ]]; then
    path=$(dirname "$path")
  fi

  alacritty --working-directory "$path" &>/dev/null &
}

# Open terminal and run given executable with options.
function openExecutableInTerminal() {
  local executable
  local path

  executable="$1"
  shift

  # Ensure absolute path
  path=$(readlink -e "$*")

  if [[ -n "$path" ]]; then
    # Safely open path in executable. The quoting is needed to handle paths with spaces.
    alacritty "${instance[@]}" "${title[@]}" -e zsh -ic "$executable \"$path\";zsh" &>/dev/null &
  else
    alacritty "${instance[@]}" "${title[@]}" -e zsh -ic "$executable $*;zsh" &>/dev/null &
  fi

}

openTerminal $# || openPathInTerminal "$*" || openExecutableInTerminal "$@"
disown
