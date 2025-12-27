#!/usr/bin/env bash

#  ┏━┓┏━╸┏━┓┏━┓┏━┓   ╺┳┓╻┏━┓╺┳╸╻ ╻
#  ┣┳┛┣╸ ┣━┛┃ ┃┗━┓    ┃┃┃┣┳┛ ┃ ┗┳┛
#  ╹┗╸┗━╸╹  ┗━┛┗━┛   ╺┻┛╹╹┗╸ ╹  ╹

set -euo pipefail

find_repositories() {
  fd --type directory --hidden --no-ignore \
    --exclude '.cache' \
    --exclude '.claude' \
    --exclude '.local' \
    --exclude '.steam' \
    --exclude 'Steam' \
    --exclude 'dev' \
    '^.git$' | sed -r 's/\/.git\/?$//'
}

main() {
  local -a repositories=()
  local -a dirty=()

  mapfile -t repositories < <(find_repositories)

  if [[ ${#repositories[@]} -eq 0 ]]; then
    printf 'No repositories found.\n' >&2
    exit 1
  fi

  printf 'Checking %d repositories:\n' "${#repositories[@]}"

  for repo in "${repositories[@]}"; do
    if [[ $(git -C "${repo}" rev-parse --is-bare-repository 2> /dev/null) != "false" ]]; then
      printf '    nogit    %s\n' "${repo}"
    elif [[ -n $(git -C "${repo}" status --short 2> /dev/null) ]]; then
      printf '    dirty    %s\n' "${repo}"
      dirty+=("${repo}")
    else
      printf '    clean    %s\n' "${repo}"
    fi
  done

  if [[ ${#dirty[@]} -eq 0 ]]; then
    printf '\nNo dirty repositories found.\n'
  else
    printf '\nFound %d dirty repositories:\n' "${#dirty[@]}"
    printf '    %s\n' "${dirty[@]}"
  fi
}

main "$@"
