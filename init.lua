-- Bootstrap Packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- auto update plugins
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost */nvim/lua/pack.lua source <afile> | PackerSync
  augroup end
]])

require('config')
require('pack')
require('plugins')
