#!/usr/bin/env bash


if [[ $# -eq 0 ]] ; then
  echo "No arguments supplied!"
  exit 1
fi

device="HUAWEI"

id=$(
  (kdeconnect-cli -a | ag "$device:" | awk '{print $3}') ||
  (kdeconnect-cli -l | ag "$device:" | awk '{print $3}')
)

if [[ -z "$id" ]]; then
  echo "Phone was not found!"
  exit 1
fi

kdeconnect-cli -d "$id" "$@"
