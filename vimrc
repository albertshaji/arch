".vimrc

filetype plugin on
set nu rnu
set encoding=utf-8
set fileformat=unix
set clipboard=unnamedplus
"set guioptions

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
au! BufWritePost ~/.vimrc so ~/.vimrc

" keep history even when file is closed
set undofile

" delete white-space/empty-line on save
au BufWritePre * %s/\s\+$//e
au BufWritepre * %s/\n\+\%$//e

" change directory
set autochdir

" save
imap <F2> <esc>:w<cr>
nmap <F2> :w<cr>

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
hi Visual cterm=bold ctermbg=darkBlue ctermfg=White
hi SpellBad cterm=bold ctermbg=darkRed ctermfg=White

" status-line
" hi StatusLine ctermfg=gray
" set laststatus=2
" set statusline=%F\     "file name
" set statusline+=%y     "file type
" set statusline+=%m     "modified flag
" set statusline+=\ %=   "align left
" set statusline+=\ %{wordcount().words}\ words,
" set statusline+=\ %L\ lines,
" set statusline+=\ %p%%
" au InsertEnter * hi StatusLine ctermfg=green
" au InsertLeave * hi StatusLine ctermfg=gray

" LaTeX compilation script
au BufRead,BufNewFile *.md,*.tex so ~/.vimtex/compile.vim

" retain clipboard contents upon leaving vim
au VimLeave * call system("xclip -o -sel c|xclip -selection c")

nnoremap <c-o> :e %:h<cr>
nnoremap <c-t> :tabnew<cr>
nnoremap <c-w> :tabclose<cr>
nnoremap <tab> gt
nnoremap <s-tab> gT

nnoremap <c-f> :exe ":FZF " . expand("%:h")<CR>

" change cursor based on modes
let &t_SI="\e[4 q"
let &t_EI="\e[1 q"

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()


" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END
