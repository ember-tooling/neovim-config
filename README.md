# Ember Neovim Config

A minimal Neovim configuration tailored for **Ember.js** development, featuring Tree-sitter for syntax highlighting and Language Server Protocol (LSP) support for Ember and TypeScript.

This is not a full-featured IDE setup — it's intentionally simple to serve as a **starting point** for your own configuration.

## ✨ Features

- 🧹 Clean Lua-based config structure
- 📦 Ember.js and TypeScript LSP integration
- 🎨 Tree-sitter-based syntax highlighting
- 🧠 Autocompletion with `blink.cmp`

## 📁 Project Structure

```
.
├── init.lua                     # Main Neovim entry point
├── lazy-lock.json               # Plugin lockfile
├── LICENSE
├── lua
│   ├── config
│   │   ├── base.lua             # Core editor settings (e.g. line numbers, tabs)
│   │   ├── keymaps.lua          # Key bindings
│   │   └── lazy.lua             # Lazy.nvim setup
│   └── plugins
│       ├── lsp.lua              # LSP config (via mason + lspconfig)
│       └── treesitter.lua       # Tree-sitter config

```

## 🚀 Getting Started

1. **Clone this repo into your Neovim config:**

```bash
git clone https://github.com/ember-tooling/neovim-config ~/.config/nvim
```

2. Open Neovim. (Plugins will be installed automatically by lazy.nvim)

```bash
nvim .
```

### Multiple Neovim Configs

If you want to maintain multiple Neovim configurations, you can clone this repo into a different directory, such as `~/.config/nvim-ember`, and then start Neovim with that config:

```bash
NVIM_APPNAME=nvim-ember nvim .
```

## ⚙️ Features

`<leader>` is set to ` `. You can change this in `lua/config/base.lua`.

### ✅ Plugin Management

[Lazy.nvim](https://github.com/folke/lazy.nvim) is used for efficient plugin management.

### ✅ Tree-sitter

Enables syntax highlighting and structural editing.
Controlled via the `ensure_installed` list to define which languages to support.

Tree-sitter intro: [YouTube – TreeSitter Explained](https://www.youtube.com/watch?v=09-9LltqWLY)

### ✅ Language Server Protocol (LSP)

Brings IDE-like features directly into Neovim.

LSP intro: [YouTube – LSP Explained in 5 Minutes](https://www.youtube.com/watch?v=LaS32vctfOY)

**Core LSP Plugins Used:**

| Plugin                                                                      | Purpose                                      |
| --------------------------------------------------------------------------- | -------------------------------------------- |
| [`mason.nvim`](https://github.com/mason-org/mason.nvim)                     | Install and manage LSPs, formatters, linters |
| [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig)                | Provides base configurations for common LSPs |
| [`mason-lspconfig.nvim`](https://github.com/mason-org/mason-lspconfig.nvim) | Bridges `mason.nvim` with `nvim-lspconfig`   |
| [`blink.cmp`](https://github.com/Saghen/blink.cmp)                          | Autocompletion UI for LSP and snippets       |

### ✅ Key Bindings

Key bindings are defined in `lua/config/keymaps.lua`.

The keymap added as an example passes the definitions of the symbol under the cursor to the quickfix list.

```lua
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
```

To see all default LSP key bindings see [global-defaults](https://neovim.io/doc/user/lsp.html#_global-defaults).

## 🚀 Alternative Neovim Setups

If you're looking for more comprehensive Neovim configurations with more plugins and UI enhancements, check out the following options:

### 📦 Kickstart.nvim

A small, single-file starter config, great for learning.

- [Kickstart.nvim GitHub](https://github.com/nvim-lua/kickstart.nvim)
- [The Only Video You Need to Get Started with Neovim](https://www.youtube.com/watch?v=m8C0Cq9Uv9o)
- [Revamping Neovim Kickstart](https://www.youtube.com/watch?v=-joJuscbM5w)

To add Ember support, simply modify the LSP section:

```lua
local servers = {
  tsserver = {},
  ember = {},
}
```

### 💤 LazyVim

[LazyVim](https://www.lazyvim.org/).

A powerful, batteries-included Neovim distribution created by [folke](https://github.com/folke).

Note: You’ll need [this PR](https://github.com/LazyVim/LazyVim/pull/6203) merged for full Ember support.

To enable Ember and TypeScript support:
- Run :LazyExtras
- Search for lang.ember and lang.typescript
- Enable using the <x> key

### 👨‍💻 User Config Examples

- [justmejulian](https://github.com/justmejulian/.dotfiles/tree/main/.config/nvim)

More coming soon—feel free to submit a PR with your own setup!

