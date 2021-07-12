# .zprofile zsh

export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="brave --enable-low-end-device-mode"
export READER="zathura"
export FILE="ranger"
export PATH="$PATH:$HOME/code/script"
export TEMPLATE="$HOME/code/VimTex/template.latex"
export SDCV_HISTFILE="$HOME/doc/NewWords"

export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'

exec startx
