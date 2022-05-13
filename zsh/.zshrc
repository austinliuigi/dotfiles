# Austin's zshrc

#################
# Login message #
#################
printf "Welcome $USER! It is currently %s.\n\n" "$(date "+%A, %B %d %Y, %I:%M %p")"
echo "                    --------          \|/                           "
echo "           \|/     |  moo?  |                                       "
echo "                    --------       --------          \|/            "
echo " \|/            (__)  /           |  moo.  |                        "
echo "         \------(oo) /             --------                         "
echo "          ||    (__)                     \  ^__^                    "
echo "          ||w--||          \|/            \ (oo)\_______        \|/ "
echo "                                            (__)\       )\/\\       "
echo "                                    \|/        ||----w |            "
echo "         \|/                                   ||     ||          \n"

#############################
# Set environment variables #
#############################
export EDITOR="vim"
export PATH=~/.local/bin:$PATH

###########
# History #
###########
HISTSIZE=1000
SAVEHIST=1000

###########
# Options #
###########
setopt autocd       # Type directory to cd
setopt nocaseglob   # Case insensitive globbing
setopt correct      # Suggest corrections for mis-spelled commands
setopt correctall   # Suggest corrections for mis-spelled arguments

##########
# Prompt #
##########
if [ -f ~/.zsh_prompt ]; then
    source ~/.zsh_prompt
fi

###########
# Aliases #
###########
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

###########
# Vi Mode #
###########
bindkey -v
export KEYTIMEOUT=1
# Change cursor based on vi mode (bar for insert, block otherwise)
zle-keymap-select() {
    if [[ ${KEYMAP} == vicmd ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]]; then
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
bindkey '[A' up-line-or-search    # Up arrow takes into account what is currently typed
bindkey '[B' down-line-or-search  # Down arrow takes into account what is currently typed

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
if [ -f ~/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi
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
if [ -f ~/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
