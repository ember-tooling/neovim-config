local lsp = require('lspconfig')
local utils = require('plugins.config.utils')

require('plugin-config.lsp.completions')

local servers = {
  --------------
  -- Languages
  --
  -- NOTE:
  --   jsonls doesn't support jsonc (it just does JSON.parse and reports errors)
  --------------
  "html",
  "yamlls",
  "cssls",
  "lua_ls",
  "tsserver",
  "bashls",

  --------------
  -- Frameworks
  "ember",
  "glint",

  --------------
  -- Tools
  "graphql",
  "tailwindcss",

  --------------
  -- Linting / Formatting
  "eslint"
}


---------------------------
-- Settings and other available servers
--  https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
---------------------------
local mySettings = {
  yamlls = {
    yaml = {
      keyOrdering = false
    }
  },
  tailwindcss = {
    tailwindCSS = {
      includeLanguages = {
        markdown = "html",
        handlebars = "html",
        javascript = {
          glimmer = "javascript"
        },
        typescript = {
          glimmer = "javascript"
        }
      }
    }
  },
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        -- https://github.com/neovim/nvim-lspconfig/issues/1700#issuecomment-1033127328
        -- I don't care about proper projects.
        -- I don't actually work in Lua outside of neovim configs
        checkThirdParty = false
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    }
  },
  tsserver = {
    maxTsServerMemory = 8000,
    implicitProjectConfig = {
      experimentalDecorators = true
    },
    -- importModuleSpecifier = "shortest"
  }
}

-- https://github.com/j-hui/fidget.nvim
require "fidget".setup {}

require("mason").setup {
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}
require("mason-lspconfig").setup {
  ensure_installed = servers,
  automatic_installation = false
}


-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp')
    .default_capabilities(vim.lsp.protocol.make_client_capabilities())

local conditional_features = function(client, bufnr)
  -- if client.server_capabilities.inlayHintProvider then
  --     vim.lsp.buf.inlay_hint(bufnr, true)
  -- end
end

for _, serverName in ipairs(servers) do
  local server = lsp[serverName]

  if (server) then
    if (serverName == 'tsserver') then
      server.setup({
        single_file_support = false,
        -- We only want the TS language server enabled when
        -- the current file is not within a glint-enabled project
        root_dir = utils.is_ts_project,
        capabilities = capabilities,
        settings = mySettings[serverName],
        on_attach = function(client, bufnr)
          conditional_features(client, bufnr)
        end
      })
    elseif (serverName == 'glint') then
      server.setup({
        -- We only want the Glint language server enabled when
        -- the current file is within a glint-enabled project
        root_dir = utils.is_glint_project,
        capabilities = capabilities,
        settings = mySettings[serverName],
        on_attach = function(client, bufnr)
          conditional_features(client, bufnr)
        end
      })
    elseif (serverName == 'eslint') then
      server.setup({
        filetypes = {
          "javascript", "typescript",
          "typescript.glimmer", "javascript.glimmer",
          "json",
          "markdown"
        },
        on_attach = function(client, bufnr)
          conditional_features(client, bufnr)
        end,
      })
    else
      server.setup({
        capabilities = capabilities,
        settings = mySettings[serverName],
        on_attach = function(client, bufnr)
          conditional_features(client, bufnr)
        end
      })
    end
  end
end
