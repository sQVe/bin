#!/usr/bin/env bash

#  ┏┳┓┏━┓╻ ╻┏┓╻╺┳╸   ┏━┓╻ ╻╻┏━┓╻ ╻╻┏━╸┏━┓┏┳┓╻
#  ┃┃┃┃ ┃┃ ┃┃┗┫ ┃    ┗━┓┣━┫┃┗━┓┣━┫┃┃╺┓┣━┫┃┃┃┃
#  ╹ ╹┗━┛┗━┛╹ ╹ ╹    ┗━┛╹ ╹╹┗━┛╹ ╹╹┗━┛╹ ╹╹ ╹╹

set -euo pipefail

readonly green='\033[0;32m'
readonly red='\033[0;31m'
readonly cyan='\033[0;36m'
readonly nc='\033[0m'
readonly shares=(media misc backup)

sudo mkdir -p /mnt/shishigami/{media,misc,backup}

echo -e "${cyan}Mounting shishigami...${nc}"

for share in "${shares[@]}"; do
  echo -n "${share}: "
  if sudo mount -t nfs -o vers=4 "shishigami:/volume1/${share}" "/mnt/shishigami/${share}"; then
    echo -e "${green}OK${nc}"
  else
    echo -e "${red}FAILED${nc}"
    exit 1
  fi
done
