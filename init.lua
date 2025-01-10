-- disable netrw at the very start of your init.lua for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('config')
require('pack')

-- auto update plugins
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost */nvim/lua/pack.lua source <afile> | PackerSync
  augroup end
]])

require('plugins')
