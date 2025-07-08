# Setup fzf
# ---------
if [[ ! "$PATH" == */home/adminbrice/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/adminbrice/.fzf/bin"
fi

source <(fzf --zsh)
