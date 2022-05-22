" For all Vim Plug related config


" Install vim-plug if not found, probably redundant
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" vim-plug
call plug#begin('~/.vim/plugged')

" Theme
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'

" GitHub Copilot
Plug 'github/copilot.vim'

" Tree 
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" ALE
Plug 'dense-analysis/ale'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Sandwich
Plug 'machakann/vim-sandwich'

call plug#end()

" onedark
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
let g:onedark_terminal_italics = 1
let g:onedark_color_overrides = {"background": {"gui": "#101114", "cterm": "234", "cterm16": "0" }}
colorscheme onedark
let g:lightline = {'colorscheme': 'onedark'}

" nvim-tree
lua << EOF
    require'nvim-tree'.setup {
        open_on_setup = true, -- auto open when opening a directory
        open_on_setup_file = true, -- auto open when opening a file
    }
EOF

" auto close tree
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

" ALE
let g:ale_sign_error = '►'
let g:ale_sign_warning = '▻'
let g:ale_sign_column_always = 1

" Markdown
let g:mkdp_auto_start = 1

" Sandwich
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

