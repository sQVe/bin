#!/usr/bin/env bash

#  ┏━╸╻╺┳╸╻ ╻╻ ╻┏┓    ┏━╸╻  ┏━┓┏┓╻┏━╸
#  ┃╺┓┃ ┃ ┣━┫┃ ┃┣┻┓   ┃  ┃  ┃ ┃┃┗┫┣╸
#  ┗━┛╹ ╹ ╹ ╹┗━┛┗━┛   ┗━╸┗━╸┗━┛╹ ╹┗━╸

function cut() {
  command cut -d '/' -f "$1" <<<"$2"
}

function is_url() {
  rg '^http' <<<"$1"
}

function is_identifier() {
  rg '/' <<<"$1"
}

if [[ $# -eq 1 ]]; then
  if [[ $(is_url "$1") ]]; then
    identifier=$(cut 4-5 "$1")
  elif [[ $(is_identifier "$1") ]]; then
    identifier="$1"
  else
    identifier="sQVe/$1"
  fi

  name=$(cut 1 "$identifier")
  repository=$(cut 2 "$identifier")
elif [[ $# -eq 2 ]]; then
  name=$1
  repository=$2
else
  echo "No valid arguments. Exiting." && exit 0
fi

git clone "git@github.com:$name/$repository.git"
