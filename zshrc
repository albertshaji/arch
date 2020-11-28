#.zshrc

#PROMPT='%F{green}%n%f@%F{blue}%m%f %F{yellow}%1~%f > '
PROMPT='%B%F{yellow}%2~ %(?.%F{green}.%F{red})>%f%b '

# syntax highlighting
source ~/.aur/color-zsh/zsh-syntax-highlighting.zsh

# vi-mode
bindkey -v
bindkey -a -r ':'
export KEYTIMEOUT=1
bindkey '^e' vi-beginning-of-line
bindkey '^y' vi-end-of-line
bindkey '^?' backward-delete-char

# tab completion
zmodload -i zsh/complist
autoload -U compinit && compinit
zstyle ':completion:*:*:*:*:*' menu select

# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history
setopt inc_append_history
setopt hist_save_no_dups
setopt hist_find_no_dups
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# skip typing cd and vim
alias -s {txt,md,py}=vim
setopt autocd

# programs
alias -g G="grep -i --color"
alias diff='diff --color=auto'
alias ydl='youtube-dl -i -o "%(title)s.%(ext)s"'
alias -g P="--playlist-items"
alias pdf='pdflatex -halt-on-error'
alias trash='gio trash --empty'

alias rm='gio trash'
alias tree='gio tree'
alias ls="ls --color --group-directories-first"
alias la='ls -A'
alias ll='ls -hl'

# pacman
alias pa='sudo pacman --needed -Sy'
alias pr='sudo pacman -Rns'
alias pl='sudo pacman -Qeq'
alias pq='sudo pacman -Ss'
alias up='sudo pacman -Syu && aur.sh brave-bin'
alias pc='yes | sudo pacman -Scc'
alias pdb='sudo rm /var/lib/pacman/db.lck'
alias mi='sudo make clean install'
alias df="df -h --exclude-type=tmpfs"

# rc files
alias zr='vim ~/.zshrc; exec zsh'
alias vr='vim ~/.vimrc'

# diary entry
alias alby='vim ~/doc/.classified/2020'

# network
alias lsw='nmcli -t -f active,ssid dev wifi'
alias rain='curl wttr.in 2> /dev/null | head -n 7'
alias ipp='printf "pirvate: "; hostname -i'
alias ip='printf "public: "; curl ipinfo.io/ip'

# git
alias gd='git diff'
alias gs="git status"
alias ga='git add'
alias gr='git reset HEAD'
alias gc='git commit -m'
alias gca='git commit --amend -m'
alias gl='git log --oneline'
alias grh='git reset --hard'
alias grs='git reset --soft'
alias grb='git rebase -i'
alias gp='git push origin +master'
alias gP='git pull origin +master'

# mainm
alias ml='printf "file %s\n" $(ls *.mp4) > list.txt'
alias mc='ffmpeg -f concat -safe 0 -i list.txt -c copy final.mp4'

# sync data to server
alias keep='sync.sh +M'
alias Keep='sync.sh -M'

# sync data back to pc
alias save='sync.sh +C'
alias Save='sync.sh -C'

# mount mtp device, like andriod phone
alias mtp='simple-mtpfs --device 1 .phone/'
-mtp() {fusermount -u .phone/}

# torrent
alias t='transmission-remote'
tl() {t --list}
tq() {killall transmission-daemon}
ta() {t --add "$1"}
tp() {t -t"$1" --stop}
tb() {t -t"$1" --start}
te() {t -t"$1" --remove}
tt() {t -t"$1" --remove-and-delete}
ti() {t -t"$1" --info}
tc() {t -l | awk '$2 == "100%"{system("transmission-remote -t"$1" -r")}'}
td()
{
if pgrep -f transmission-daemon >/dev/null
then
    transmission-remote --list
else
    transmission-daemon -c ~/tem/
fi
}

# markdown to html
html() {pandoc $1 -t html5 --template t -s -o ${1%.*}.html --mathjax}

cc() {gcc $1; ./a.out}

# vocabulary
tail -n 5 ~/doc/.words | uniq
shuf -n1 /usr/share/dict/british-english

open_with_fzf() {
    fd -t f -H -I | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
}
cd_with_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
}
pacs() {
    sudo pacman -Syy $(pacman -Ssq | fzf -m --preview="pacman -Si {}" --preview-window=:hidden --bind=space:toggle-preview)
}
zle -N open_with_fzf

bindkey '^f' open_with_fzf
bindkey -s '^d' "cd_with_fzf\n"

# Change cursor shape on vi-mode
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
