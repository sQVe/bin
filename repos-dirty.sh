#!/usr/bin/env bash

#  ┏━┓┏━╸┏━┓┏━┓┏━┓   ╺┳┓╻┏━┓╺┳╸╻ ╻
#  ┣┳┛┣╸ ┣━┛┃ ┃┗━┓    ┃┃┃┣┳┛ ┃ ┗┳┛
#  ╹┗╸┗━╸╹  ┗━┛┗━┛   ╺┻┛╹╹┗╸ ╹  ╹

repositories=$(fd --hidden --strip-cwd-prefix --exclude ".{local}" '^.git$' | sed -r 's/\/.git\/?$//')

if [[ -z "$repositories" ]]; then
  echo "No repositories found. Exiting."
  exit
else
  echo "Found $(echo "$repositories" | wc -l) repositories. Checking status:"
fi

dirty_repositories=()
for repo in $repositories; do
  echo "  ✔  $repo"

  if [[ $(git -C "$repo" rev-parse --is-bare-repository) == "true" ]]; then
    break
  fi

  if [[ -n $(git -C "$repo" status --short) ]]; then
    dirty_repositories+=("$repo")
  fi
done
dirty_repositories_list=$(printf '  %s\n' "${dirty_repositories[@]}")

if [[ -z ${dirty_repositories[*]} ]]; then
  echo "No dirty repositories found."
else
  echo "Found $(echo "$dirty_repositories_list" | wc -l) dirty repositories:"
  echo "$dirty_repositories_list"
fi
