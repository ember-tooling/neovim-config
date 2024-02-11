-- Following instructions from: https://github.com/wbthomason/packer.nvim?tab=readme-ov-file#bootstrapping
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- There are a fow plugin managers in the neovim ecosystem.
-- This one is older, but very stable, and is the inspiration for
-- the newer, less stable, plugin managers.
--
-- The main thing is that a package manager needs to
-- - have a way to reference a git repository, as all plugins live on git repositories
--   (many default to GitHub, and may require additional options to use other git hosts)
-- - A config hook for setting up and instantiating the plugin.
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- We split configs by topic, because plugin setup
  -- tends to be a bit lengthy, and multiple files help
  -- keep focused no what each set of plugins
  require('plugins.plugins-editor')(use);
  require('plugins.plugins-syntax-highlighting')(use);
  require('plugins.plugins-language-features')(use);

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
