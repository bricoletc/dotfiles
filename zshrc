# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/brice/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode tmux zoxide)

source $ZSH/oh-my-zsh.sh

#### User configuration #####

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

######## Aliases #########
# oh-my-zsh users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# reduce blue light
alias rshift='redshift -l 52:0 -t 5000:3500'

# system listing
alias mysys='inxi -Fxz'

# use neovim
alias vim=nvim

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Browse up and down
alias u='clear; cd ../; pwd; ls -lhGgo'
alias d='clear; cd -; ls -lhGgo'

# git
# see https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git for inspiration
alias gis='git status'
alias gil='git log --oneline --decorate'
alias gild='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'' --date=short'
alias gils='git log --stat'
alias gid='git diff'

# pyenv
eval "$(pyenv init -)"


###### Functions ###########
mcd(){ mkdir -p "$1" && cd "$1";}
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
PATH=${Softs}/ansiweather/:$PATH
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

export PATH

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/pulse/extra/usr/lib/x86_64-linux-gnu/ # Fix: https://askubuntu.com/questions/1135065/cant-run-pulse-secure-on-ubuntu-19-04-because-libwebkitgtk-1-0-so-0-is-missing PulseUi PulseSecure VPN for Ubuntu > 18
export LD_LIBRARY_PATH

export GOPATH=${Softs}/go
export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
