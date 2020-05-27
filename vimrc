".vimrc

filetype plugin on
set nu rnu
set encoding=utf-8
set fileformat=unix
set clipboard=unnamedplus
"set guioptions+=a

" highlight search matches
set incsearch

" show search matches as you type
set hlsearch

" ignore case in search
set ignorecase

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

" allow deep search in 'find' cmd
set path+=**

" display all TAB completion matches
set wildmenu

" disable banner in netrw
let g:netrw_banner=0

" indention
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
nmap < <<
nmap > >>

" dictionary words tab-complete
set dictionary+=/usr/share/dict/british-english
set complete+=k

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

" update vimrc changes when saved
au! BufWritePost ~/x/vimrc so ~/x/vimrc

" keep history even when file is closed
set undofile

" delete white-space/empty-line on save
au BufWritePre * :%s/\s\+$//e
au BufWritePre * :v/\_s*\S/d

" change directory
lcd %:p:h

" save and quit
imap <F2> <esc>:w<cr>
nmap <F2> :w<cr>

" sort
map \s :sort<cr>

" select all
noremap <c-a> <esc>ggVG<cr>

" number +/-
noremap <c-i> <c-a>
noremap <c-d> <c-x>

" spell check
imap <F8> <esc>:setlocal spell! spelllang=en_us<cr>
nmap <F8> :setlocal spell! spelllang=en_us<cr>

" set encryption method to blowfish
setlocal cm=blowfish

" syntax highlighting
syntax enable
colorscheme default
hi LineNr ctermbg=black ctermfg=gray
hi CursorLineNr cterm=none ctermfg=white ctermbg=black
hi Visual cterm=bold ctermbg=darkBlue ctermfg=White
hi SpellBad cterm=bold ctermbg=darkRed ctermfg=White
hi StatusLine ctermfg=gray

" status-line
set laststatus=2
set statusline=%F\     "file name
set statusline+=%y     "file type
set statusline+=%m     "modified flag
set statusline+=\ %=   "align left
set statusline+=\ %{wordcount().words}\ words,
set statusline+=\ %L\ lines,
set statusline+=\ %p%%
au InsertEnter * hi StatusLine ctermfg=green
au InsertLeave * hi StatusLine ctermfg=gray

" compilation/execution script
so ~/.vimtex/compile.vim

" retain clipboard contents upon leaving vim
au VimLeave * call system("xclip -o -sel c|xclip -selection c")

nmap F :find<space>
