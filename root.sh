#!/usr/bin/env bash

#  ┏━┓┏━┓┏━┓╺┳╸
#  ┣┳┛┃ ┃┃ ┃ ┃
#  ╹┗╸┗━┛┗━┛ ╹

set -euo pipefail

readonly next_root_pwd='/tmp/next-root-pwd'

pwd > "${next_root_pwd}"
sudo -i "$@"
