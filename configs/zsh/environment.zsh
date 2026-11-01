# environment variables
# see: modules/home/env.nix

# History
export KEYTIMEOUT=1
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# ZSH Autosuggestions optimizations
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# FZF-tab config
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .cache"
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export PREVIEW_CMD="bat --style=numbers --color=always {} || cat {}"
export FZF_CTRL_T_OPTS="--preview \"$PREVIEW_CMD\" --height 50%"
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --margin=0 --padding=0"
