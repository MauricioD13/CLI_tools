#!/bin/bash

apt update
apt -y upgrade
apt install neovim fuck fzf httpie

file_perm=$(stat -c "%a" vim_config.sh)

chmod u+x vim_config.sh

/bin/bash vim_config.sh neovim
