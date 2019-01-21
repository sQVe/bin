#!/usr/bin/env bash

#  ┏━┓┏━╸┏━┓┏━┓┏━┓   ┏┓ ┏━╸╻ ╻╻┏┓╻╺┳┓
#  ┣┳┛┣╸ ┣━┛┃ ┃┗━┓   ┣┻┓┣╸ ┣━┫┃┃┗┫ ┃┃
#  ╹┗╸┗━╸╹  ┗━┛┗━┛   ┗━┛┗━╸╹ ╹╹╹ ╹╺┻┛

repositories="$(fd --hidden --exclude ".{builds,local}" --type directory '^.git$' . | sed -r 's/\/.git$//')"

if [[ -z "$repositories" ]]; then
  echo "No repositories found. Exiting."
  exit
else
  echo "Found $(echo "$repositories" | wc -l) repositories. Checking status..."
fi

repositoriesBehind=()
repositoriesAbleToFastForward=()
for repo in $repositories; do
  status="$(git -C "$repo" fetch && git -C "$repo" status)"

  if [[ -n "$(echo "$status" | ag 'branch is behind')" ]]; then
    repositoriesBehind+=("$repo")

    if [[ -n "$(echo "$status" | ag 'can be fast-forwarded')" ]] &&
       [[ -z "$(echo "$status" | ag -o 'Changes not staged')" ]]; then
      repositoriesAbleToFastForward+=("$repo")
    fi
  fi
done
repositoriesBehindList=$(printf '  %s\n' "${repositoriesBehind[@]}")
repositoriesAbleToFastForwardList=$(printf '  %s\n' "${repositoriesAbleToFastForward[@]}")

if [[ -z "${repositoriesBehind[*]}" ]]; then
  echo "No repositories behind found."
else
  echo "Found $(echo "$repositoriesBehindList" | wc -l) repositories behind:"
  echo "$repositoriesBehindList"

  if [[ -z  ${repositoriesAbleToFastForward[*]} ]]; then
    echo "No repositories able to fast-forward."
  else
    echo "Found $(echo "$repositoriesAbleToFastForwardList" | wc -l) repositories to fast-forward:"
    echo "$repositoriesAbleToFastForwardList"
    echo -n "Would you like to fast-forward? [Y/n] "
    read -r answer

    if [[ "$answer" != "N" && "$answer" != "n" ]]; then
      for repo in $repositoriesAbleToFastForwardList; do
        git -C "$repo" pull
      done
    fi
  fi
fi
