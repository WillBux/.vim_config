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
