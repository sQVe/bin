#!/usr/bin/env bash

#  ┏━┓┏━╸┏━┓┏━┓┏━┓   ╺┳┓╻┏━┓╺┳╸╻ ╻
#  ┣┳┛┣╸ ┣━┛┃ ┃┗━┓    ┃┃┃┣┳┛ ┃ ┗┳┛
#  ╹┗╸┗━╸╹  ┗━┛┗━┛   ╺┻┛╹╹┗╸ ╹  ╹

set -euo pipefail

# Find all git repositories in the current directory.
find_repositories() {
  fd --hidden --strip-cwd-prefix --exclude ".{local}" '^.git$' | sed -r 's/\/.git\/?$//'
}

# Check the status of a repository.
check_repository() {
  local status
  local repo="$1"
  status=$(git -C "${repo}" status --short)

  if [[ -n "${status}" ]]; then
    printf '    dirty    %s\n' "${repo}"
  else
    printf '    clean    %s\n' "${repo}"
  fi
}

# Check the status of all repositories.
check_all_repositories() {
  local repositories=()
  mapfile -t repositories < <(find_repositories)

  if [ ${#repositories[@]} -eq 0 ]; then
    printf 'No repositories found. Exiting.\n' >&2
    exit 1
  fi

  printf 'Checking %d repositories:\n' "${#repositories[@]}"
  for repo in "${repositories[@]}"; do
    if [[ $(git -C "${repo}" rev-parse --is-bare-repository 2> /dev/null) != "false" ]]; then
      printf '    nogit    %s\n' "${repo}"
    else
      check_repository "${repo}"
    fi
  done
}

# Report any dirty repositories found.
report_dirty_repositories() {
  local -a dirty_repositories=()
  mapfile -t dirty_repositories < <(find_repositories | while read -r repo; do
    if [[ $(git -C "${repo}" status --short) ]]; then
      printf '%s\n' "${repo}"
    fi
  done)

  if ((${#dirty_repositories[@]} == 0)); then
    printf '\nNo dirty repositories found.\n'
  else
    printf '\nFound %d dirty repositories:\n' "${#dirty_repositories[@]}"
    for repo in "${dirty_repositories[@]}"; do
      printf '    %s\n' "${repo}"
    done
  fi
}

# Main function.
main() {
  check_all_repositories
  report_dirty_repositories
}

main "$@"
