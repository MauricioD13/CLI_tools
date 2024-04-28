#!/bin/bash


# Install of tools
echo "[TOOLS] Installing tools"
apt update
apt -y upgrade
apt -y install bat neovim fzf httpie zsh tldr jq net-tools git

if [ declare | grep -i -q "wsl" ]; then
	os_type="wsl"
	echo "[SYSTEM] You are in WSL"
else
	
	echo "[SYSTEM] You are in Linux"

fi

# neovim: text editor
# fzf: recursive finder
# httpie: curl with steroids
# tldr: resume command
# jq: parse and print json
# net-tools: command ifconfig
# git: I don´t need to explain

# Get user path and user name
user_path="$(pwd | sed 's/\/CLI_tools$//')"
user="$(pwd | sed 's/\/home\/\([^/]*\)\/.*/\1/')"

if [[ ! $? -eq 0 ]]; then
	echo "Error"
	exit 1
fi

# Config shell to be zsh
echo "[SHELL] Starting configuration of shell"
if [[ "$SHELL" = "/bin/bash" ]]; then

	chsh -s $(which zsh)
fi
echo "[SHELL] Configuration of shell complement"


# Install and config complement oh-my-zsh
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

# Different theme depend of the selection
read -p "[INPUT] Shell for [hack] hacking or [dev] develop?" shell_type


if [[ "$shell_type" = "hack" ]]; then
	
	if [[ $? -eq 0 ]]; then
		echo "[SHELL] Fail downloading theme"
	fi
	if [[ ! -f $user_path/.oh-my-zsh/themes/heapbytes.zsh-theme ]]; then 

		mv $user_path/CLI_tools/heapbytes.zsh-theme $user_path/.oh-my-zsh/themes/

	fi

	# TODO
	sed -i 's/ZSH_THEME=".*"/ZSH_THEME="heapbytes"/' $user_path/.zshrc

elif [[ "$shell_type" = "dev" ]]; then
		
	apt -y install fonts-powerline

	sed -i 's/ZSH_THEME=".*"/ZSH_THEME="agnoster"/' $user_path/.zshrc
	
	# using dircolors.ansi-dark
	if [[ ! -f $user_path/.dircolors ]]; then 
		curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark --output $user_path/.dircolors
		eval `dircolors $user_path/.dircolors`
	fi
	if [ $os_type="wsl" ]; then
		echo "[WSL] For agnoster to work it's neccesary to clone this repo: https://github.com/powerline/fonts.git and install the font using the install.ps1 file"
		echo "[WSL] Commands to run:"
		echo "[POWERSHELL] git clone https://github.com/powerline/fonts.git"
		echo "[POWERSHELL] powershell.exe -executionpolicy unrestricted install.ps1"
	fi
else
	echo "[SHELL] Option not available" 

fi

# Custom config of alias and prompt context
if  ! cat $user_path/.zshrc | grep -i -q "CUSTOM CONFIG" ; then

	cat custom_zshrc.txt >> $user_path/.zshrc 
fi

# Plugins Configuration
echo "[SHELL] Installing and config plugins"


if [[ ! -d $user_path/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $user_path/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if ! cat $user_path/.zshrc | grep -i -q "plugins=(git zsh-autosuggestions zsh-zyntax-highlightinh sudo web-search)"; then
	sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting sudo web-search)/' $user_path/.zshrc 
fi

file_perm=$(stat -c "%a" vim_config.sh)

chmod u+x vim_config.sh
echo "[VIM] Starting vim configuration"
#/bin/bash vim_config.sh neovim
