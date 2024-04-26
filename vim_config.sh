#!/bin/bash

#!/bin/bash
# If the inline editor is vim the command is the following
# vim_config.sh vim
# the other option is neovim
if [[ $1 = "vim" ]]; then
	if [ -d ~/.config/nvim/ ]; then
		if [ -f ~/.config/nvim/init.vim ]; then
			vim_file=~/.config/nvim/init.vim
		else
			touch ~/.config/nvim/init.vim
			vim_file=~/config/nvim/init.vim
		fi
	else
		mkdir ~/config/nvim/
		touch ~/config/nvim/init.vim
	fi
elif [[ $1 = "neovim" ]]; then
	if [ -f /etc/vim/vimrc ]; then
		vim_file=/etc/vim/vimrc
	else
		touch ~/.vim
		vim_file=~/.vim
	fi
else
	echo "There is no option for that editor"
fi


echo "let skip_defaults_vim=1
set wrap
syntax enable
set wildmenu
set showcmd
set incsearch
set clipboard=unnamed
set autoindent
set nostartofline
set number
set numberwidth=1
set encoding=utf8
set showmatch
set relativenumber
set mouse=a
set ignorecase
set title
set background=dark" >> $vim_file
# Mauro edit (Mark for bash search)
