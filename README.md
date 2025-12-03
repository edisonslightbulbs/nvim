# Seamless Neovim setup 🍻

[![GitHub stars](https://img.shields.io/github/stars/edisonslightbulbs/nvim)](https://github.com/edisonslightbulbs/nvim/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/edisonslightbulbs/nvim)](https://github.com/edisonslightbulbs/nvim/network)
[![GitHub license](https://img.shields.io/github/license/edisonslightbulbs/nvim.svg?style=flat-square)](https://github.com/edisonslightbulbs/nvim/blob/lua/LICENSE)

[Neovim](https://neovim.io) is a modern, highly extensible, and configurable text editor designed for efficient text editing. This repository contains a Neovim configuration using Lua, offering a simple and elegant way to manage and extend your text editing experience.

## Features

- Easy-to-read and maintain configuration :wrench:
- Pre-configured settings that work out-of-the-box :package:
- A set of configured [plugins](https://github.com/edisonslightbulbs/nvim/blob/lua/lua/plugins/init.lua) to optimize productivity :wrench:

## Getting started

1. Install the latest [Neovim](https://github.com/neovim/neovim/releases) (v0.10 or newer).
2. Launch Neovim and let [`lazy.nvim`](https://github.com/folke/lazy.nvim) bootstrap the plugin set defined in [`lua/plugins/init.lua`](lua/plugins/init.lua).
3. Run the self-test to verify the installation:

   ```bash
   nvim --headless "+Lazy! sync" "+lua require('utils.selftest').run()" +qa
   ```

   The self-test checks for required plugins (Mason, LSP, Treesitter, Telescope, Conform, nvim-tree) and confirms the configuration modules load cleanly.

## Promotion

[Star if you liked](https://github.com/edisonslightbulbs/nvim/stargazers).

[Share if you loved](https://github.com/edisonslightbulbs/nvim "Copy project link").

[Contribute to collaborate](https://github.com/edisonslightbulbs/nvim/fork).
