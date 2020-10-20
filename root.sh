#!/usr/bin/env bash

#  ┏━┓┏━┓┏━┓╺┳╸
#  ┣┳┛┃ ┃┃ ┃ ┃
#  ╹┗╸┗━┛┗━┛ ╹

temp_file_path='/tmp/next-root-pwd'

pwd >|"$temp_file_path"
sudo -i "$@"
