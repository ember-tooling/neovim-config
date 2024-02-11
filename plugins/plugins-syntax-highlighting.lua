return function(use)
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
end
