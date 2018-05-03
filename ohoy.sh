#!/usr/bin/env bash

OHOY_HOME="$HOME/.ohoy"
OHOY_SCRIPT="$OHOY_HOME/scripts/run.sh"
OS=$(uname | awk '{print tolower($0)}')
REPO_URL="https://repo.dex.nu/artifactory/exp-binhub/ohoy/$OS/"

if [[ ! -d "$OHOY_HOME" ]]; then
  mkdir -p "$OHOY_HOME"
  LATEST=$(curl -s "$REPO_URL" | grep ohoy | tail -1 | cut -d '"' -f2-)
  LATEST_URL=$REPO_URL$LATEST

  echo "No ohoy installation found, downloading from $LATEST_URL"
  curl -L "$LATEST_URL" | tar xz -C "$OHOY_HOME"
fi

sudo gpasswd -a "$USER" docker

trap '
  sudo gpasswd -d "$USER" docker;
  exit 1;
  ' INT

$OHOY_SCRIPT "$@"

sudo gpasswd -d "$USER" docker
