# Austin's zshrc

#################
# Login message #
#################
function center_text() {
    local text=$1
    #echo ${#text}
    local -i pad_length=$((($(tput cols)-${#text})/2))
    pad_length=$((pad_length>=0?pad_length:0))
    #echo $pad_length
    local pad=${(pl:$pad_length:: :)}
    echo $pad$text
}

# local welcome_message=$(printf "Welcome $USER! It is currently %s\n\n" "$(date "+%A, %B %d %Y, %I:%M %p")")
local welcome_message=$(printf "Welcome $USER!")
center_text $welcome_message
echo "\n\n"
center_text "                    --------          \|/                           "
center_text "           \|/     |  moo?  |                                       "
center_text "                    --------       --------          \|/            "
center_text " \|/            (__)  /           |  moo.. |                        "
center_text "         \------(oo) /             --------                         "
center_text "          ||    (__)                     \  ^__^                    "
center_text "          ||w--||          \|/            \ (oo)\_______       \|/  "
center_text "                                            (__)\       )\/\        "
center_text "                                    \|/        ||----w |            "
center_text "         \|/                                   ||     ||          \n"

#############################
# Set environment variables #
#############################
export EDITOR="nvim"
export PATH=~/.local/bin:$PATH
export MANPAGER='nvim +Man!'

###########
# History #
###########
HISTFILE="$HOME/.zsh_history"	# File to store history in
HISTSIZE=999999			# Number of lines of history to keep in memory
SAVEHIST=$HISTSIZE		# Number of lines to keep in history file

setopt HIST_IGNORE_ALL_DUPS	# Do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS	# Do not save duplicated command
setopt HIST_REDUCE_BLANKS	# Remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME	# Append command to history file immediately after execution
setopt EXTENDED_HISTORY		# Record command start time

###########
# Options #
###########
setopt autocd       # Type directory to cd
setopt nocaseglob   # Case insensitive globbing
setopt correct      # Suggest corrections for mis-spelled commands
setopt correctall   # Suggest corrections for mis-spelled arguments

#########
# Tools #
#########

#------#
# Tmux #
#------#

# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#     tmux attach -t default || tmux new -s default
# fi

#-----#
# Fzf #
#-----#

export FZF_DEFAULT_OPTS="--bind right:accept"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -f ~/.zsh/zsh_plugins/fzf-tab/fzf-tab.plugin.zsh ]; then
    source ~/.zsh/zsh_plugins/fzf-tab/fzf-tab.plugin.zsh
fi

zstyle ':fzf-tab:*' continuous-trigger 'right'
zstyle ':fzf-tab:complete:*' fzf-flags '--query='

# function fz() {
# 	print -z $1 $(fzf)
# }

#--------#
# Zoxide #
#--------#

! [ -z "$(command -v zoxide)" ] && eval "$(zoxide init zsh)"

##########
# Prompt #
##########
if [ -f ~/.zsh/zsh_prompt ]; then
    source ~/.zsh/zsh_prompt
fi

###########
# Aliases #
###########
if [ -f ~/.zsh/zsh_aliases ]; then
    source ~/.zsh/zsh_aliases
fi

###########
# Vi Mode #
###########
bindkey -v
export KEYTIMEOUT=1
# Change cursor based on vi mode (bar for insert, block otherwise)
zle-keymap-select() {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select
# Change cursor to bar for each new prompt
zle-line-init() {
    echo -ne '\e[5 q'
}
zle -N zle-line-init
# Edit current command line in vim with ctrl-e
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

############
# Bindings #
############
# bindkey '[A' history-beginning-search-backward    # Up arrow takes into account what is currently typed
# bindkey '[B' history-beginning-search-forward     # Down arrow takes into account what is currently typed
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

##########
# Colors #
##########
export CLICOLOR=1
export LSCOLORS="ExGxFxDxCxDxDxhbhdacEc"
export LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32"

##################
# Autocompletion #
##################
# Autosuggestion plugin (real-time suggestion based on history or completion)
if [ -f ~/.zsh/zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-beginning-search-backward-end history-beginning-search-forward-end)

autoload -U compinit
zstyle ':completion:*' menu select                          # Menu completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'         # Case insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # Add color to completion menu
compinit
setopt menu_complete                                        # Complete first match even in ambiguous
unsetopt list_beep                                          # Turn off beeping on ambiguous completions
setopt glob_dots                                            # Match hidden files

#######################
# Syntax highlighting #
#######################
if [ -f ~/.zsh/zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

################
# Zsh Vim Mode #
################

# zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
# source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
