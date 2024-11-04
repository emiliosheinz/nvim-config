# Neovim Config

This repository serves as my personal Neovim configuration setup, tailored to enhance my development workflow. It includes various plugins, settings, and custom key mappings designed to improve productivity and streamline coding tasks. Below, you'll find detailed explanations of the key components and instructions for setting up the configuration on your own machine.

![Neovim preview](./docs/images/preview.png)

## ✨ Features and Plugins

- Pre-configured [key mappings](./lua/emiliosheinz/core/keymap.lua), [options](./lua/emiliosheinz/core/options.lua), and [commands](./lua/emiliosheinz/core/commands.lua)
- [Catppuccin](https://github.com/catppuccin/nvim) color scheme 🤩
- [lazy.nvim](https://github.com/folke/lazy.nvim) for easy and performant plugin management
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for fuzzy file searching
- [Harpoon](https://github.com/ThePrimeagen/harpoon) to navigate with just a few keystrokes
- Excellent file explorer provided by [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
- [none-ls](https://github.com/nvimtools/none-ls.nvim) for seamless integration with linters and formatters
- [mason.nvim](https://github.com/williamboman/mason.nvim) and [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) for easy installation and management of LSP servers
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) for great completions and snippets
- Simple but powerful terminal UI for git commands with [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)
- And much more 🚀

## ⚡️ Requirements

- Neovim >= 0.10.0
- Git >= 2.19.0 (for cloning this repo)
- a [Nerd Font](https://www.nerdfonts.com/) (optional, but needed to display some icons)
- lazygit (if you want to use lazygit)
- a **C** compiler for nvim-treesitter. See [this](https://github.com/nvim-treesitter/nvim-treesitter#requirements) for more information
- [ripgrep](https://github.com/BurntSushi/ripgrep) for telescope.nvim
- [iTerm2](https://iterm2.com/) or any terminal that supports true color and undercurl
    
## 🛠️ Instalation

- Make sure to backup your current Neovim config if you have one:
        
    ```bash 
    # required
    mv ~/.config/nvim{,.backup}

    # optional but recommended
    mv ~/.local/share/nvim{,.backup}
    mv ~/.local/state/nvim{,.backup}
    mv ~/.cache/nvim{,.backup}
    ```    
- Clone this repo into your Neovim config folder
    
    ```bash
    git clone https://github.com/emiliosheinz/nvim-config ~/.config/nvim
    ```
- Remove the `.git` folder, so you can add it to your own repo later
    
    ```bash
    rm -rf ~/.config/nvim/.git
    ```

- Start Neovim 🥳
    
    ```bash
    nvim
    ```

## 📚 Usage

In this section you'll find some useful key mappings, commands, and workflows to help you get started with the configuration.

### Find and replace on multiple files 

Reference: https://www.youtube.com/watch?v=9JCsPsdeflY

1. Search for the term you wan to replace using Telescope: `<leader>fs`
2. Send all the results to the quickfix list using `<C-q>` 
3. Run `:cfdo %s/old/new/g | update | bd` to replace all occurrences of `old` with `new` in all files in the quickfix list

💡 **Pro tip**: In case you want to preview the changes before applying them, you can use the `c` flag in the `:s` command. This will open a confirmation window for each occurrence.
