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
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

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
alias pu='sudo pacman -Syu'
alias pc='yes | sudo pacman -Scc'
alias pdb='sudo rm /var/lib/pacman/db.lck'
alias mi='sudo make clean install'
alias df="df -h --exclude-type=tmpfs"

# rc files
alias zr='vim ~/.zshrc; exec zsh'
alias vr='vim ~/.vimrc'

# diary entry
alias alby='vim ~/doc/diary/2020'

# network
alias wifi='nmcli -t -f active,ssid dev wifi | egrep "^yes"'
alias rain='curl wttr.in 2> /dev/null | head -n 7'
alias ipp='printf "pirvate: "; hostname -i'
alias ip='printf "public: "; curl ipinfo.io/ip'

# git
alias gd='git diff'
alias gs="git status"
alias ga='git add'
alias gua='git reset HEAD'
alias gc='git commit -m'
alias gca='git commit --amend -m'
alias gl='git log --oneline'
alias gr='git reset --hard'
alias grb='git rebase -i'
alias gp='git push origin +master'
alias gpb='git pull origin +master'

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
alias mtp='simple-mtpfs --device 1 .mtp/'
-mtp() {fusermount -u .mtp/}

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
    transmission-daemon -c ~/out/
fi
}

# markdown to html
html() {pandoc $1 -t html5 --template t -s -o ${1%.*}.html --mathjax}

cc() {gcc $1; ./a.out}
tail -n 7 ~/doc/.words | uniq
