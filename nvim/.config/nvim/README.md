<!--
Author: Anant Sharma
Email: anantsh.88@gmail.com
GitHub: https://github.com/anant-357
Date Created: 2025-07-12
Last Modified: 2025-07-13
Description: Document to understand my nvim config
-->

# Neovim Configuration

This is a personal Neovim configuration based on Lua. It is designed to be lightweight, fast, and functional for web and systems development.

## Features

-   **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim) for fast and easy plugin management.
-   **Theme:** [Gruvbox Material](https://github.com/sainnhe/gruvbox-material) for a clean and modern look.
-   **File Explorer:** [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) for a powerful and customizable file explorer.
-   **Fuzzy Finder:** [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for fast and efficient file searching, grepping, and more.
-   **Syntax Highlighting:** [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for fast and accurate syntax highlighting.
-   **LSP:** Built-in LSP support with configurations for Lua, Rust, and Go.
-   **Formatting:** [conform.nvim](https://github.com/stevearc/conform.nvim) for automatic code formatting.
-   **Keymaps:** Sensible keymaps for improved ergonomics and productivity.

## Plugin Manager

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. The plugin specifications are located in the `lua/plugins/` directory.

## Plugins

### Core

-   [folke/lazy.nvim](https://github.com/folke/lazy.nvim): A modern plugin manager for Neovim.
-   [folke/lazydev.nvim](https://github.com/folke/lazydev.nvim): Helper for developing Neovim plugins.
-   [folke/neoconf.nvim](https://github.com/folke/neoconf.nvim): A Neovim setup for managing global and project-local settings.

### UI

-   [sainnhe/gruvbox-material](https://github.com/sainnhe/gruvbox-material): A high-contrast and vibrant color scheme.
-   [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons): Icons for file types.
-   [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua): A file explorer for Neovim.
-   [folke/which-key.nvim](https://github.com/folke/which-key.nvim): A popup that displays keybindings in real time.
-   [folke/twilight.nvim](https://github.com/folke/twilight.nvim): A plugin that dims inactive parts of the code.
-   [folke/snacks.nvim](https://github.com/folke/snacks.nvim): A collection of small UI enhancements.

### Utility

-   [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim): A library of Lua functions for Neovim plugins.
-   [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): A highly extendable fuzzy finder over lists.
-   [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim): A plugin for formatting code.

### Treesitter

-   [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): A framework for using Tree-sitter parsers for syntax highlighting, indentation, and more.
-   [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects): Additional textobjects for Treesitter.

## Keymaps

| Keymap        | Description                               |
| ------------- | ----------------------------------------- |
| `<leader>sf`  | Search for files with Telescope.          |
| `<leader>sg`  | Search in Git files with Telescope.       |
| `<leader>sp`  | Search for a phrase with Telescope.       |
| `<leader>/`   | Fuzzy find in the current buffer.         |
| `<leader>gd`  | Go to definition with Telescope.          |
| `<leader>gr`  | Go to references with Telescope.          |
| `<leader>gI`  | Go to implementations with Telescope.     |
| `<leader>D`   | Go to type definition with Telescope.     |
| `<leader>ds`  | Search for document symbols with Telescope. |
| `<leader>ws`  | Search for workspace symbols with Telescope.|
| `<leader>f`   | Format the current buffer.                |
| `<leader>?`   | Show buffer local keymaps with which-key. |
| `<C-h/j/k/l>` | Move between splits.                      |

## LSP

This configuration has LSP support for the following languages:

-   Lua (`lua-language-server`)
-   Rust (`rust-analyzer`)
-   Go (`gopls`)

The LSP configurations are located in the `lsp/` directory.

## Installation

1.  Clone this repository to your Neovim configuration directory:
    ```bash
    git clone https://github.com/anant-357/dotfiles-wayland/nvim ~/.config/nvim
    ```
2.  Start Neovim. `lazy.nvim` will automatically install the plugins.

Enjoy!