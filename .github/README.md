# AstroNvim Template

**NOTE:** This is for AstroNvim v4+

A template for getting started with [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## ⚡ Requirements

- [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
- [Tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md) and Node (To generate the `Latex` TS parser)
- Terminal with true color support and good font icons handling (Kitty)
- Optional Requirements:
  - [ripgrep](https://github.com/BurntSushi/ripgrep) - live grep telescope search (`<Leader>fw`)
  - [lazygit](https://github.com/jesseduffield/lazygit) - git ui toggle terminal (`<Leader>tl` or `<Leader>gg`)
  - [btop](https://github.com/aristocratos/btop) - process viewer toggle terminal (`<Leader>tt`)
  - [IPython](https://github.com/ipython/ipython) - python repl toggle terminal (`<Leader>tp`)
  - [Node](https://nodejs.org/en/) - Node is needed for a lot of the LSPs, and for the node repl toggle terminal (`<Leader>tn`)
  - `lua5.1`, `luarocks`, and lua library files (`liblua5.1-0-dev`) packages - `luarocks` support for plugin installation (`neorg` plugin currently)
  - `dvipng` executable in path and ImageMagick's MagickWand (`libmagickwand-dev`) - render latex snippets in `neorg`

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.

#### Clone the repository

```shell
git clone https://github.com/<your_user>/<your_repository> ~/.config/nvim
```

#### Start Neovim

```shell
nvim
```
