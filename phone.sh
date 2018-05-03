#!/usr/bin/env bash

if [[ "$#" -eq 0 ]] ; then
  echo "No arguments supplied!"
  exit 1
fi

if [[ $1 =~ ^(-h|--help|help)$ ]]; then
  command kdeconnect-cli --help
  exit 0
fi

device="HUAWEI"

id="$(
  (command kdeconnect-cli -a | ag "$device:" | awk '{print $3}') ||
  (command kdeconnect-cli -l | ag "$device:" | awk '{print $3}')
)"

if [[ -z "$id" ]]; then
  echo "Phone was not found!"
  exit 1
fi

command kdeconnect-cli -d "$id" "$@"
