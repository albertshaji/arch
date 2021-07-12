# .zshrc zsh

PROMPT='%F{yellow}%2~ %B%(?.%F{green}.%F{red})>%f%b '

# enable vi-mode
bindkey -v
# don't open comand-line on typing ":" in the vi-mode
bindkey -a -r ':'
export KEYTIMEOUT=1
bindkey '^a' vi-beginning-of-line
bindkey '^e' vi-end-of-line
bindkey '^?' backward-delete-char

# tab completion
zmodload -i zsh/complist
autoload -U compinit && compinit
zstyle ':completion:*' menu yes select

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history
setopt inc_append_history
setopt hist_save_no_dups
setopt hist_find_no_dups
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# skip typing vim
alias -s {txt,md,py}=nvim
alias vim=nvim

# skip typing cd
setopt autocd

alias diff='diff --color=auto'
alias ydl='youtube-dl -i -o "%(title)s.%(ext)s"'
alias pdflatex='pdflatex -halt-on-error'
alias trash='gio trash'
alias ls='ls --color --group-directories-first'
alias la='ls -A'
alias ll='ls -hl'
alias gpush='git push origin +master'
alias gpull='git pull origin +master'
alias -g tor=transmission-remote
alias -g tord=transmission-daemon
alias pacman-unlock='sudo rm /var/lib/pacman/db.lck'
alias mci='sudo make clean install'
alias journal='vim ~/doc/.classified/2021'
alias lastword='tail -n 10 ~/doc/.word | uniq'


# change cursor shape on vi-mode
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]
  then
    echo -ne "\033[1 q"
  else
    echo -ne "\033[4 q"
  fi
}
zle -N zle-keymap-select
# on new ternimal line
_fix_cursor() { echo -ne '\e[4 q' }
precmd_functions+=(_fix_cursor)
# on entering and leaving vim
zle-line-init() { zle -K viins; echo -ne "\033[4 q" }
zle-line-finish() { echo -ne "\033[1 q" }
zle -N zle-line-finish

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
source ~/code/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
