-- Setting up a language server requires a number of tools
-- - configs for how to wire up the raw language server tools to the editor
--   (mason.nvim, mason-lspconfig.nvim, nvim-lspconfig)
-- - completions sources, as we may want multiple ways of combination suggestions
--   from different LSPs, or non-LSPs
--   These are called "completion providers" and can sometimes include snippets engines
--   (nvim-cmp)
-- - downloading the actual LSP client if it does not exist already locally
--   (mason.nvim)
--
return function(use)
  -- icons
  use 'onsails/lspkind.nvim'
  -- server management and installation
  use 'neovim/nvim-lspconfig'
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }

  -- improved signature information
  use 'ray-x/lsp_signature.nvim'
  -- LSP booting status, if the LSP exposes / emits that information
  use 'j-hui/fidget.nvim'

  use {
    "smjonas/inc-rename.nvim",
    config = function()
      -- Default: <leader>r
      require("inc_rename").setup()
    end,
  }

  ---- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      -- Completion Sources
      'hrsh7th/cmp-nvim-lsp',
      -- Considered hacky (by the author)
      -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/issues/12#issuecomment-1128820104
      -- 'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      -- Freezes the whole editor
      --  https://github.com/hrsh7th/cmp-path/issues/68#issuecomment-1704351464
      -- 'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      -- 'f3fora/cmp-spell',

      -- Auto-closing tag suggestions
      'buschco/nvim-cmp-ts-tag-close',

      -- It bothers me that this person's name is all caps
      'L3MON4D3/LuaSnip'
    }
  }


  -- Format on save
  use {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          -- Use a sub-list to run only the first available formatter
          javascript = { { "prettierd", "prettier" } },
          ['javascript.glimmer'] = { { "prettierd", "prettier" } },
        },
        format_on_save = {
          timeout_ms = 250,
          lsp_fallback = true,
        },
        notify_on_error = false,
        formatters = {
          prettierd = {
            require_cwd = true
          },
          prettier = {
            require_cwd = true
          }
        }
      })
    end
  }
end
