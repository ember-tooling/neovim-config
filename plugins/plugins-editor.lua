return function(use)
  -- Respect .editorconfig settings and apply
  -- them to (neo)vim per-relevant buffer automatically
  use 'editorconfig/editorconfig-vim'

  -- For File browsing
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

    -- You may want to remove this line,
    -- and configure your own mappings
    config.use_default_mappings()

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
end
