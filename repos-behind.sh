#!/usr/bin/env bash

#  ┏━┓┏━╸┏━┓┏━┓┏━┓   ┏┓ ┏━╸╻ ╻╻┏┓╻╺┳┓
#  ┣┳┛┣╸ ┣━┛┃ ┃┗━┓   ┣┻┓┣╸ ┣━┫┃┃┗┫ ┃┃
#  ╹┗╸┗━╸╹  ┗━┛┗━┛   ┗━┛┗━╸╹ ╹╹╹ ╹╺┻┛

repositories=$(fd --hidden --strip-cwd-prefix --exclude ".{local}" '^.git$' | sed -r 's/\/.git$//')

ping -c 1 -W 15 1.1.1.1 &> /dev/null || (echo "Unable to connect to internet. Exiting" && exit 1)

if [[ -z "$repositories" ]]; then
  echo "No repositories found. Exiting."
  exit
else
  echo "Found $(echo "$repositories" | wc -l) repositories. Checking status:"
fi

behind_repos=()
fastforwardable_repos=()
for repo in $repositories; do
  if [[ $(git -C "$repo" rev-parse --is-bare-repository) == "true" ]]; then
    break
  fi

  status=$(git -C "$repo" fetch &> /dev/null && git -C "$repo" status)

  if [[ -n "$(echo "$status" | rg 'branch is behind')" ]]; then
    if [[ -n "$(echo "$status" | rg 'can be fast-forwarded')" ]] \
      && [[ -z "$(echo "$status" | rg -o 'Changes not staged')" ]]; then
      fastforwardable_repos+=("$repo")
      echo "  🔄  $repo"
    else
      behind_repos+=("$repo")
      echo "  ❌ $repo"
    fi
  else
    echo "  ✔ $repo"
  fi
done
behind_repos_list=$(printf '  %s\n' "${behind_repos[@]}")
fastforwardable_repos_list=$(printf '  %s\n' "${fastforwardable_repos[@]}")

if [[ -z "${fastforwardable_repos[*]}" ]] && [[ -z "${behind_repos[*]}" ]]; then
  echo "No repositories behind found."
else
  if [[ -n ${behind_repos[*]} ]]; then
    echo "Found $(echo "$behind_repos_list" | wc -l) non fastforwardable repositories behind:"
    echo "$behind_repos_list"
  fi

  if [[ -n ${fastforwardable_repos[*]} ]]; then
    echo "Found $(echo "$fastforwardable_repos_list" | wc -l) repositories to fast-forward:"
    echo "$fastforwardable_repos_list"
    echo -n "Would you like to fast-forward? [Y/n] "
    read -r answer

    if [[ "$answer" != "N" && "$answer" != "n" ]]; then
      for repo in $fastforwardable_repos_list; do
        git -C "$repo" pull
        git -C "$repo" submodule update --init --recursive
      done
    fi
  fi
fi
