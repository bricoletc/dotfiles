# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# system listing
alias mysys='inxi -Fxz'

# some more ls aliases
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

### Personal settings

## Aliases
# Sets location to cambridgem and lowers faytime temperature (from 5500 to 5000K)
alias rshift='redshift -l 52:0 -t 5000:3500'
alias op='xdg-open'
# git
alias gis='git status'
alias gil='git log --all --decorate --oneline --graph'
alias gils='git log' #for 'simple'
alias gib='git branch'
alias gid='git diff'
alias gic='git checkout'
alias gicane='git commit --amend --no-edit'
#alias git=hub # Extend git with hub commands

# use neovim
alias vim=nvim


###########Credit : https://github.com/stephenturner/oneliners #############
# Browse up and down
alias u='clear; cd ../; pwd; ls -lhGgo'
alias d='clear; cd -; ls -lhGgo'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
mcd(){ mkdir -p "$1" && cd "$1";}
#######################################################################

############Credit : https://www.cyberciti.biz/faq/linux-unix-convert-hex-to-decimal-number/######
h2d(){
  echo "ibase=16; $@"|bc
}
d2h(){
  echo "obase=16; $@"|bc
}

d2b(){ 
	echo "obase=2; $@"|bc 
}
b2d(){
	echo "ibase=2; $@"|bc 
}
##############################################################################


# Switch local/remote ssh config
confSwitch(){
	if [ ~/.ssh/config -ef ~/.ssh/config_local ]; then
		ln -sf ~/.ssh/config_remote ~/.ssh/config
	else
		ln -sf ~/.ssh/config_local ~/.ssh/config
	fi
}

randomPwd(){
	pwd=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c $1)
	echo "${pwd}"
}

sdu(){
	du -h -d $1 $2
}

################## EBI -related #################

######## Cluster ########

# Login
CL_CODON="bletcher@codon_ext"
# Covid VM
CL_COVID="ubuntu@140.238.99.97"

# Tunnel to jupyter lab running on cluster
yoda_tunnel_ssh(){
	host_name=$1
	if [[ $host_name =~ [0-9][0-9]-[0-9][0-9] ]]; then
		echo "Hostname OK; running background tunnel on port 8889 reachable on port 1111"
		ssh -N -f -L 1111:hh-yoda-"${host_name}".ebi.ac.uk:8889 yoda
	else
		echo "Usage: provide host name as xx-xx, where x is decimal digit"
	fi
}

# Mount yoda research dir
alias myoda='sshfs bletcher@yoda:/nfs/leia/research/iqbal /mnt/yoda'
alias myoda_ext='sshfs bletcher@yoda_ext:/ /mnt/yoda'
alias mnoah_ext='sshfs bletcher@noah_ext:/ /mnt/noah'
alias mcodon_ext='sshfs bletcher@codon_ext:/ /mnt/codon'


# generate OTP for connecting to ligate. The TOTP token is TOTP12901CC5
alias ligate_otp='oathtool --totp -b -d 6 YV32MLUIBBYW6FZ3YS2HFDVGZ6O2F56S'

## Samba file share
alias smbEBI='nautilus --no-desktop smb://pcserv.windows.ebi.ac.uk' # Also have a personal folder by appending '/bletcher'
##################################################

## Paths
Softs="${HOME}/Softs"
PATH=${Softs}:$PATH
PATH=${Softs}/clion-2020.3.1/bin/:$PATH
PATH=${Softs}/pycharm-2020.1/bin/:$PATH
PATH=${Softs}/bcftools/bin/:$PATH
PATH=/usr/local/texlive/2018/bin/x86_64-linux/:$PATH
PATH=${Softs}/art_bin_MountRainier/:$PATH
PATH=${Softs}/bwa/:$PATH
PATH=${Softs}/bowtie2-2.4.1-linux-x86_64/:$PATH
PATH=${Softs}/vg/:$PATH
PATH=${Softs}/vcflib/bin:$PATH
PATH=${Softs}/artemis:${Softs}/seaview:$PATH
PATH=${Softs}/cdhit:$PATH
PATH=${Softs}/standard-RAxML/:$PATH
PATH=${Softs}/minimap2-2.17_x64-linux/:$PATH
PATH="${Softs}/singularity_3.5.0/builddir/":$PATH
PATH="${Softs}/enaBrowserTools/python3/":$PATH
PATH=${HOME}/.poetry/bin:${PATH}
PATH=/home/brice/Desktop/git_repos/dev_venv/bin/keyring:$PATH 
PATH=/home/brice/Desktop/main_PhD/git_repos/iqbal-lab/martin_bioinf_scripts/python:$PATH
PATH=/usr/local/pulse/:$PATH

# pyenv
export PATH="/home/brice/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/pulse/extra/usr/lib/x86_64-linux-gnu/ # Fix: https://askubuntu.com/questions/1135065/cant-run-pulse-secure-on-ubuntu-19-04-because-libwebkitgtk-1-0-so-0-is-missing PulseUi PulseSecure VPN for Ubuntu > 18
export LD_LIBRARY_PATH

# bash vi mode. Escape first to get out of insert mode.
set -o vi

export GOPATH=${Softs}/go
export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# tmux completion
source ~/tmux.completion.bash


## Convenience jumps
GMTOOLS="/home/brice/Desktop/main_PhD/git_repos/gramtools"
ANALYSIS="/home/brice/Desktop/main_PhD/analyses"
GITS="/home/brice/Desktop/main_PhD/git_repos"
WKPLACE="/home/brice/Desktop/workplace"
THESIS="/home/brice/Desktop/materials_PhD/writing/thesis/my_thesis_cam"
PRES="/home/brice/Desktop/materials_PhD/my_presentations/"
PAPER="/home/brice/Desktop/materials_PhD/writing/papers/"
SNAKEFMT="/home/brice/Desktop/extra_curri_PhD/snakemake_formatting/snakefmt"
COVID="/home/brice/Desktop/main_PhD/side_projects/covid_pca"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/brice/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/brice/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/brice/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/brice/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
source "$HOME/.cargo/env"
