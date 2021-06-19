" ~/.vimrc gvim

filetype plugin on

"set nu rnu
set encoding=utf-8
set fileformat=unix
set clipboard=unnamedplus

" highlight search matches
set incsearch

" ignore case in search
"set ignorecase

" update when the file changes from outside
set autoread

" select in vim visual mode; use mouse=v for terminal select
set mouse=a

" allow to be cursor anywhere in vim
set virtualedit=all

" mouse Scroll up/dowm
map <ScrollWheelUp> <c-y>

" telling vim not act like vi
set nocompatible

" show :<tab> completion matches
set wildmenu

" indention
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" dictionary words tab-complete
set dictionary+=/usr/share/dict/british-english
set complete+=k

" keep history even when file is closed
set undofile

" change directory
set autochdir

" set encryption method to blowfish
set cm=blowfish

" indent if beginning of line. else, do completion.
function! Tabing()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction
inoremap <expr> <tab> Tabing()
inoremap <s-tab> <c-p>

nmap <F2> :w<cr>
imap <F2> <esc>:w<cr>i
nmap <F6> :set spell!<cr>
imap <F6> <esc>:set spell!<cr>i
nnoremap <c-n> :tabnew<cr>
nnoremap <c-f> :FZF<cr>
nnoremap <c-t> :below terminal<cr>

syntax enable
colorscheme peachpuff
hi Visual cterm=bold ctermbg=darkblue ctermfg=white
hi SpellBad cterm=bold ctermbg=darkred ctermfg=white
hi SpellCap cterm=bold ctermbg=lightyellow ctermfg=white

" markdown to latex/beamer using pandoc
command Latex au! BufWritePost *.md :silent !{pandoc %  -o %:r.pdf &}
command Beamer au! BufWritePost *.md :silent !{pandoc % -t beamer -o %:r.pdf &}
au! BufWritePost *.tex :silent !{pdflatex -halt-on-error % >/dev/null &}
au BufRead,BufNewFile *.md,*.tex nmap <F5> :! zathura %:r.pdf & disown<cr><cr>
" clean vim window in case of error
nmap <F12> :redraw!<cr>

" retain clipboard content on leaving vim
au VimLeave * call system("xclip -o -sel c|xclip -selection c")

" delete white-space/empty-line on save
au BufWritePre * %s/\s\+$//e
au BufWritepre * %s/\n\+\%$//e

" change cursor style based on the mode
au InsertEnter,InsertLeave * set cul!

" disable banner in netrw
let g:netrw_banner=0

call plug#begin()
    Plug 'junegunn/fzf.vim'
call plug#end()
