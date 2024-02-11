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


  -- Respect .editorconfig settings and apply
  -- them to (neo)vim per-relevant buffer automatically
  use 'editorconfig/editorconfig-vim'

  -- TreeSitter configures what languages you want to highlight.
  -- There are many more than what is configured here, but here,
  -- are *a* minimal set of languages used to work on web apps
  --
  -- See https://github.com/nvim-treesitter/nvim-treesitter
  -- for more
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require("nvim-treesitter.install").prefer_git = true
      require 'nvim-treesitter.configs'.setup {
        autotag = {
          enable = true,
          filetypes = {
            "html",
            "javascript", "typescript",
            "typescript.glimmer", "javascript.glimmer",
            "markdown",
            "glimmer", "handlebars", "hbs",
          }
        },
        ensure_installed = {
          -- Web Languages
          "javascript", "typescript",
          "html", "css", "regex",
          -- Web Framework Languages
          "glimmer",
          -- Web Transport Languages
          "graphql",
          -- Documentation Languages
          "markdown", "markdown_inline",
          -- "help", -- missing?
          -- "comment", -- slow?
          "jsdoc",
          -- Configuration Languages
          "toml", "jsonc",
          "lua", "vim",
          -- Scripting Languages
          "bash",
          "jq",
          -- Systems Languages
          "c", "cmake",
          -- Utility Syntaxes
          "diff",
          "jq",
          "git_rebase", "gitcommit", "gitignore"
        },
        ignore_install = {
          "json" -- jsonc is better
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true
        },
      }

      require('ts_context_commentstring').setup({})
      vim.g.skip_ts_context_commentstring_module = true
    end
  }

  -- For File browsing
  --
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker"
    }
  }

  -- Comments in embedded languages via treesitter
  -- (be able to comment in JS within Markdown, etc)
  use { 'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
    end
  }

  -- Better comment support.
  -- In particular, integrating with tree-sitter's AST
  -- for toggling block comments, and customizing
  -- the comment blocks for Glimmer and Handlebars
  --
  -- See: https://github.com/alexlafroscia/tree-sitter-glimmer/issues/125
  use { 'b3nj5m1n/kommentary', config = function()
    local config = require('kommentary.config')

    config.configure_language('default', {
      single_line_comment_string = 'auto',
      multi_line_comment_strings = 'auto',
      hook_function = function()
        require('ts_context_commentstring').update_commentstring()
      end,
    })

    config.configure_language("typescript.glimmer", {
      multi_line_comment_strings = { "{{!--", "--}}" },
    })
    config.configure_language("javascript.glimmer", {
      multi_line_comment_strings = { "{{!--", "--}}" },
    })
    config.configure_language("glimmer", {
      multi_line_comment_strings = { "{{!--", "--}}" },
    })
    config.configure_language("handlebars", {
      multi_line_comment_strings = { "{{!--", "--}}" },
    })
  end }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
