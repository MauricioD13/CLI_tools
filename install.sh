#!/bin/bash

if [ "$#" -eq 0 ]; then
	echo "[PARAM] User parameter isn´t provided"
	exit 1
fi

# Install of tools
echo "[TOOLS] Installing tools"
#apt update
#apt -y upgrade
#apt install neovim fzf httpie zsh tldr jq

# neovim: text editor
# fzf: recursive finder
# httpie: curl with steroids
# tldr: resume command
# jq: parse and print json


user_path="$(pwd | sed 's/\/CLI_tools$//')"
user="$(pwd | sed 's/\/home\/\([^/]*\)\/.*/\1/')"

echo "$user_path"
echo "$user"
echo "$?"
if [[! $? -eq 0 ]]; then
	echo "Error"
	exit 1
fi



if [ $user != "guasonito" ];then
	echo "No se ha obtenido el usuario"
	exit 1
fi

echo "[SHELL] Starting configuration of shell"
if [[ "$SHELL" = "/bin/bash" ]]; then

	chsh -s $(which zsh)
fi
echo "[SHELL] Configuration of shell complement"

if [[ ! -d $user_path/.oh-my-zsh ]]; then
	
	echo "[SHELL] Installing Oh-my-zsh"
	
	# Oh my zsh as complement of zsh
	su - $user sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	if [[! $? -eq 0 ]]; then
		echo "[SHELL] Fail to install oh-my-zsh"
	else
		echo "[SHELL] Installed Oh-my-zsh"
	fi
fi
if [[ ! -f $user_path/.oh-my-zsh/themes/heapbytes.zsh-theme ]]; then 
	echo "$user_path/CLI_tools/heapbytes.zsh-theme"
	mv $user_path/CLI_tools/heapbytes.zsh-theme $user_path/.oh-my-zsh/themes/
	if [[ $? -eq 0 ]]; then
		echo "[SHELL] Fail downloading theme"
	fi
	# TODO
	sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="heapbytes"/' $user_path/.zshrc
	
fi

file_perm=$(stat -c "%a" vim_config.sh)

chmod u+x vim_config.sh
echo "[VIM] Starting vim configuration"
#/bin/bash vim_config.sh neovim
