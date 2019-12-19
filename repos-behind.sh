#!/usr/bin/env bash

#  ┏━┓┏━╸┏━┓┏━┓┏━┓   ┏┓ ┏━╸╻ ╻╻┏┓╻╺┳┓
#  ┣┳┛┣╸ ┣━┛┃ ┃┗━┓   ┣┻┓┣╸ ┣━┫┃┃┗┫ ┃┃
#  ╹┗╸┗━╸╹  ┗━┛┗━┛   ┗━┛┗━╸╹ ╹╹╹ ╹╺┻┛

repositories=$(fd --hidden --exclude ".{builds,local}" --type directory '^.git$' . | sed -r 's/\/.git$//')

if [[ -z "$repositories" ]]; then
  echo "No repositories found. Exiting."
  exit
else
  echo "Found $(echo "$repositories" | wc -l) repositories. Checking status:"
fi

repositories_behind=()
repositories_able_to_fastforward=()
for repo in $repositories; do
  host=$(git -C "$repo" remote get-url origin | cut -d ':' -f 1 | cut -d '@' -f 2)

  if ping -c 1 -W 2 "$host" &>/dev/null; then
    status=$(git -C "$repo" fetch &>/dev/null && git -C "$repo" status)

    echo "  ✔  $repo"

    if [[ -n "$(echo "$status" | rg 'branch is behind')" ]]; then
      repositories_behind+=("$repo")

      if [[ -n "$(echo "$status" | rg 'can be fast-forwarded')" ]] &&
        [[ -z "$(echo "$status" | rg -o 'Changes not staged')" ]]; then
        repositories_able_to_fastforward+=("$repo")
      fi
    fi
  else
    echo "  ❌ $repo"
  fi
done
repositories_behind_list=$(printf '  %s\n' "${repositories_behind[@]}")
repositories_able_to_fastforward_list=$(printf '  %s\n' "${repositories_able_to_fastforward[@]}")

if [[ -z "${repositories_behind[*]}" ]]; then
  echo "No repositories behind found."
else
  echo "Found $(echo "$repositories_behind_list" | wc -l) repositories behind:"
  echo "$repositories_behind_list"

  if [[ -z ${repositories_able_to_fastforward[*]} ]]; then
    echo "No repositories able to fast-forward."
  else
    echo "Found $(echo "$repositories_able_to_fastforward_list" | wc -l) repositories to fast-forward:"
    echo "$repositories_able_to_fastforward_list"
    echo -n "Would you like to fast-forward? [Y/n] "
    read -r answer

    if [[ "$answer" != "N" && "$answer" != "n" ]]; then
      for repo in $repositories_able_to_fastforward_list; do
        git -C "$repo" pull
      done
    fi
  fi
fi
