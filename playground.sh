#!/usr/bin/env bash

#  ┏━┓╻  ┏━┓╻ ╻┏━╸┏━┓┏━┓╻ ╻┏┓╻╺┳┓
#  ┣━┛┃  ┣━┫┗┳┛┃╺┓┣┳┛┃ ┃┃ ┃┃┗┫ ┃┃
#  ╹  ┗━╸╹ ╹ ╹ ┗━┛╹┗╸┗━┛┗━┛╹ ╹╺┻┛

set -euo pipefail

PLAYGROUND_DIR="${HOME}/code/personal/playground"

# Set nvim's cwd without changing shell directory.
nvim -c "cd ${PLAYGROUND_DIR}" \
  +vsplit \
  +"terminal npm run start" \
  +'wincmd h' \
  +'norm G$' \
  "${PLAYGROUND_DIR}/src/index.ts"
