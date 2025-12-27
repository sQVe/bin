#!/usr/bin/env bash

#  ┏━┓┏━╸┏━┓┏━┓┏━┓   ┏┓ ┏━╸╻ ╻╻┏┓╻╺┳┓
#  ┣┳┛┣╸ ┣━┛┃ ┃┗━┓   ┣┻┓┣╸ ┣━┫┃┃┗┫ ┃┃
#  ╹┗╸┗━╸╹  ┗━┛┗━┛   ┗━┛┗━╸╹ ╹╹╹ ╹╺┻┛

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

if ! ping -c 1 -W 15 1.1.1.1 &> /dev/null; then
  echo "Unable to connect to internet. Exiting" >&2
  exit 1
fi

repositories=$(find_repositories)

if [[ -z "${repositories}" ]]; then
  echo "No repositories found. Exiting."
  exit 0
fi

repo_count=$(echo "${repositories}" | wc -l)
echo "Found ${repo_count} repositories. Checking status:"

behind_repos=()
fastforwardable_repos=()

while IFS= read -r repo; do
  if [[ $(git -C "${repo}" rev-parse --is-bare-repository 2> /dev/null) == "true" ]]; then
    continue
  fi

  if ! status=$(git -C "${repo}" fetch 2> /dev/null && git -C "${repo}" status 2> /dev/null); then
    echo "  ⚠ ${repo} (fetch failed)"
    continue
  fi

  if echo "${status}" | rg -q 'branch is behind'; then
    if echo "${status}" | rg -q 'can be fast-forwarded' && ! echo "${status}" | rg -q 'Changes not staged'; then
      fastforwardable_repos+=("${repo}")
      echo "  🔄  ${repo}"
    else
      behind_repos+=("${repo}")
      echo "  ❌ ${repo}"
    fi
  else
    echo "  ✔ ${repo}"
  fi
done <<< "${repositories}"

if [[ ${#fastforwardable_repos[@]} -eq 0 ]] && [[ ${#behind_repos[@]} -eq 0 ]]; then
  echo "No repositories behind found."
  exit 0
fi

if [[ ${#behind_repos[@]} -gt 0 ]]; then
  echo "Found ${#behind_repos[@]} non fastforwardable repositories behind:"
  printf '  %s\n' "${behind_repos[@]}"
fi

if [[ ${#fastforwardable_repos[@]} -gt 0 ]]; then
  echo "Found ${#fastforwardable_repos[@]} repositories to fast-forward:"
  printf '  %s\n' "${fastforwardable_repos[@]}"
  echo -n "Would you like to fast-forward? [Y/n] "
  read -r answer

  if [[ "${answer}" != "N" && "${answer}" != "n" ]]; then
    for repo in "${fastforwardable_repos[@]}"; do
      git -C "${repo}" pull
      git -C "${repo}" submodule update --init --recursive
    done
  fi
fi
