# My NvChad dotfiles

[NV Chad](https://github.com/NvChad/NvChad#nvchad) is a [neovim](https://neovim.io/) config written in lua.
It's a base config where the user can change the default to their liking in a custom folder (lua/custom).
This repository is my custom folder for NvChad.

# Installation

## Neovim

[Neovim installation guide](https://github.com/neovim/neovim/wiki/Installing-Neovim).
I like to install neovim from source. Here's how I do it:

```bash
cd ~/clones # A directory for cloned repository
git clone https://github.com/neovim/neovim
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
nvim -v
```

## NvChad

Clone NvChad to it's own config:

```bash
git clone https://github.com/NvChad/NvChad ~/.config/NvChad --depth 1
```

I like to have my neovim configs in separate folder, and use an alias for the default one. Here is the alias:

```.bashrc
alias nvim="NVIM_APPNAME=NvChad nvim"
```

To update NvChad, either run `git pull` in the config directory (and NOT in the lua/custom one) or `NvChadUpdate` in editor.

## My custom config

Copy the config:

```bash
cd ~/.config/NvChad/lua/
git clone https://github.com/rokonio/NvChad-config custom/
```

Run nvim, see everything being downloaded, relaunch and tadaaa !

# Langs

In NvChad, you can install lsp with Mason, but for anything more advanced, you have to do it manually.
This is where my config tries to come handy. Just enable a flag in configs/langs.lua for your language and the config will set it up for you.

I currently only have settings for languages I use, but my goal is to make an opiniated configuration for the maximum languages I can.
If your configuration for a language you use isn't present or could be improved, feel free to open an issue or even submit a pull request !

When you enable a lang, don't forget to run `:MasonInstallAll` for the changes to take effects.

## Adding a lang

To add a lang, first create a local variable with its name. For example:

```lua
local lua = false
```

Add the Treesitter parser name in M.parser. For example:

```lua
return {
  enable_parser("lua", lua)
}
```

Add the Mason lsp name in M.lsp. For example:

```lua
return {
  enable_lsp("lua-language-server", lua),
  enable_lsp("stylua", lua),
}
```

Add the null-ls source name if needed in M.sources For example:

```lua
return {
  enable_src(b, b.formatting.stylua, lua),
}
```

And if needed add a plugin in M.plugin:

```lua
return {
  enable_plugin({--[[ Your plugin --]]}, you_lang)
}
```
