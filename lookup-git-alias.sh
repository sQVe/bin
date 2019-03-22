#!/usr/bin/env bash

#  ╻  ┏━┓┏━┓╻┏ ╻ ╻┏━┓   ┏━╸╻╺┳╸   ┏━┓╻  ╻┏━┓┏━┓
#  ┃  ┃ ┃┃ ┃┣┻┓┃ ┃┣━┛   ┃╺┓┃ ┃    ┣━┫┃  ┃┣━┫┗━┓
#  ┗━╸┗━┛┗━┛╹ ╹┗━┛╹     ┗━┛╹ ╹    ╹ ╹┗━╸╹╹ ╹┗━┛

if [[ $# -eq 0 ]]; then
  echo "No alias fragment given. Exiting."
  exit 0
fi

matches=$(ag '^alias' < "$ZIM_HOME"/modules/git/init.zsh | ag --case-sensitive "$1")
result=""

while read -r line; do
  alias=$(echo "$line" | sed -r 's/^alias (\w+).*/\1/')
  cmd=$(echo "$line" | cut -d '=' -f 2- | sed -r "s/'//g")
  description=$(ag --case-sensitive "^\s+\* \`$alias\`" \
                  < "$ZIM_HOME"/modules/git/README.md | \
                  ag -v "\` shadows" | \
                  cut -d ' ' -f 5-)

  if [[ -n "$alias" && -n "$cmd" ]]; then
    result="$result\n$alias%%$cmd%%$description"
  fi
done <<< "$matches"

echo -e "$result" | column -t -s "%%"
