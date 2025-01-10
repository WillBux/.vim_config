vim.opt.encoding="utf-8"
vim.loader.enable()

-- disable netrw at the very start of your init.lua for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- true 256bit color support
vim.opt.termguicolors = true


-- line numbers
vim.opt.number=true
vim.opt.numberwidth=1

-- spelling, underline with red
-- in plugins file after theme

-- history
vim.opt.history=500

-- Enable filetype plugins
vim.cmd([[
filetype plugin on
filetype indent on
]])

-- Read file again whenever switching buffers or focusing back onto vim
vim.opt.autoread=true
vim.cmd([[au FocusGained,BufEnter * :silent! !]])
-- write file when leaving focus or leaving window, don't run save hooks (e.g. linters)
vim.cmd([[au FocusLost,WinLeave * :silent! noautocmd w]])

-- set <leader> to ,
vim.g.mapleader = ","

-- Map <Space> to / (search) 
vim.keymap.set("n", "<space>", "/")

-- Ignore case when searching
vim.opt.ignorecase=true

-- When searching try to be smart about cases 
vim.opt.smartcase=true


-- :WS sudo saves the file 
vim.cmd([[command! WS execute 'w !sudo tee % > /dev/null' <bar> edit!]])

-- Set scrolloff to 7
-- When scrolling leave at least 7 lines above and below the cursor
vim.opt.so=7

-- Turn on the Wild menu
vim.opt.wildmenu=true

-- custom splits
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")

-- Open new split panes to right and bottom, which feels more natural
vim.opt.splitbelow=true
vim.opt.splitright=true

-- Use spaces instead of tabs
vim.opt.expandtab=true

-- Be smart when using tabs ;)
vim.opt.smarttab=true

-- 1 tab == 4 spaces
vim.opt.shiftwidth=4
vim.opt.tabstop=4

vim.opt.ai=true -- Auto indent
vim.opt.si=true -- Smart indent
vim.opt.wrap=true -- Wrap lines


-- toggle commands
vim.keymap.set("n", "<leader>ta", "<cmd>ALEToggle<CR>")
vim.keymap.set("n", "<leader>tp", "<cmd>PeakToggle<CR>")
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>")

--whichkey 
vim.o.timeout = true
vim.o.timeoutlen = 150
