# Vars
	HISTFILE=~/.zsh_history
	SAVEHIST=20000 
	setopt inc_append_history # To save every command before it is executed 
	setopt share_history # setopt inc_append_history
	git config --global push.default current
# Pure theme
	autoload -U promptinit;
	promptinit prompt pure
# Aliases
	alias wget='wget -c'
	alias untar='tar -zxvf '
	alias getpass="openssl rand -base64 64"
	alias ping='ping -c 5'
	alias ipe='curl ipinfo.io/ip'
	alias ipi='ipconfig getifaddr en0'
	alias gac="git add . && git commit -a -m "
	alias vim="vim"
	alias dcu="docker-compose up --build -d"
	alias dcd="docker-compose down"
	alias dex="dex-fn"
	alias dsc="dsc-fn"
	alias drmc="drmc-fn"
	alias drmi="drmi-fn"
	alias grep="grep --color -i"
	mkdir -p /tmp/log

function dex-fn {
    docker exec -it $1 /bin/bash
}

function drmi-fn {
	docker rmi $(docker images -q)
}

function drmc-fn {
    docker rm $(docker ps -aq)
}

function dsc-fn {
    docker stop $(docker ps -aq)
}
	# This is currently causing problems (fails when you run it anywhere that isn't a git project's root directory)
	# alias vs="v `git status --porcelain | sed -ne 's/^ M //p'`"

# Settings
	export LANG=en_US.UTF-8
	export GREP_COLOR=31
	export PATH="$PATH:/Users/svl/projects/flutter/bin"

source ~/dotfiles/zsh/plugins/fixls.zsh

#Functions
	# Loop a command and show the output in vim
	loop() {
		echo ":cq to quit\n" > /tmp/log/output 
		fc -ln -1 > /tmp/log/program
		while true; do
			cat /tmp/log/program >> /tmp/log/output ;
			$(cat /tmp/log/program) |& tee -a /tmp/log/output ;
			echo '\n' >> /tmp/log/output
			vim + /tmp/log/output || break;
			rm -rf /tmp/log/output
		done;
	}

 	# Custom cd
 	c() {
 		cd $1;
 		ls;
 	}
 	alias cd="c"

# For vim mappings: 
	stty -ixon

# Completions
# These are all the plugin options available: https://github.com/robbyrussell/oh-my-zsh/tree/291e96dcd034750fbe7473482508c08833b168e3/plugins
#
# Edit the array below, or relocate it to ~/.zshrc before anything is sourced
# For help create an issue at github.com/parth/dotfiles

autoload -U compinit

for plugin ($plugins); do
    fpath=(~/dotfiles/zsh/plugins/oh-my-zsh/plugins/$plugin $fpath)
done

compinit

source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/history.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/key-bindings.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/completion.zsh
source ~/dotfiles/zsh/plugins/vi-mode.plugin.zsh
source ~/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/keybindings.sh

# Fix for arrow-key searching
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/pure.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/async.zsh

export PATH=$PATH:$HOME/dotfiles/utils
