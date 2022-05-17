set encoding=utf-8

" line numbers
set number

" spelling, underline with redaoeuad
set spell
highlight clear SpellBad
highlight SpellBad term=NONE cterm=underline ctermfg=196 gui=undercurl guifg=#ff0000

" history
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Read file again whenever switching buffers or focusing back onto vim
set autoread
au FocusGained,BufEnter * :silent! !
" write file when leaving focus or leaving window, don't run save hooks (e.g. linters)
au FocusLost,WinLeave * :silent! noautocmd w

" set <leader> to ,
let mapleader = ","

" Map <Space> to / (search) 
map <space> /

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase


" :WS sudo saves the file 
command! WS execute 'w !sudo tee % > /dev/null' <bar> edit!

" Set scrolloff to 7
" When scrolling leave at least 7 lines above and below the cursor
set so=7

" Turn on the Wild menu
set wildmenu

" custom splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

