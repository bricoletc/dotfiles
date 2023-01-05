# Setup fzf
# ---------
if [[ ! "$PATH" == */home/brice/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/brice/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/brice/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/brice/.fzf/shell/key-bindings.zsh"
