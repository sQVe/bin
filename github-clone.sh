#!/usr/bin/env bash

#  ┏━╸╻╺┳╸╻ ╻╻ ╻┏┓    ┏━╸╻  ┏━┓┏┓╻┏━╸
#  ┃╺┓┃ ┃ ┣━┫┃ ┃┣┻┓   ┃  ┃  ┃ ┃┃┗┫┣╸
#  ┗━┛╹ ╹ ╹ ╹┗━┛┗━┛   ┗━╸┗━╸┗━┛╹ ╹┗━╸

if [[ $# -eq 1 ]]; then
  name="sQVe"
  repository=$1
elif [[ $# -eq 2 ]]; then
  name=$1
  repository=$2
else
  exit 0
fi

git clone "git@github.com:$name/$repository.git"
