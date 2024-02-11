# neovim-config
A starter config to help you setup NeoVim for Ember development

## Trying it out

```bash
nvim -u ./init.vim
```

Notes about this demo:
- Force exit with `:qa!` (normal exit is `:q`)
- The Mouse is enabled
- The default `<leader>` key is backslash
- Save a file with `:w`
- this config has no custom key-mappings
  Everything is "defaults", so you'll need to read up on the documentation of specific plugins to see if they provide default keymaps (or make your own!)

Plugins used

- Syntax highlighting: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- File tree: [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
  Open with `:Neotree`


## Debugging

```bash
cd test-project
pnpm i
```

- try to reproduce the issue you're seeing locally in the test-project
- submit a PR 
- 🎉
