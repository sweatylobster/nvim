# Maxvim aka Hugovim

Contains my personal Lua configuration managed with [Lazy](https://lazy.folke.io/).
Has too many plugins, which I intend to clean.

I really like managing dotfiles with Nix.
Learned a lot from copying [Carlos Becker's
dotfiles](https://github.com/caarlos0/dotfiles) in mid September 2024.
You can see my [current config
here](https://github.com/sweatylobster/nixos-config).

I'm also working on a [nixvim](https://github.com/nix-community/nixvim)
implementation of it, which lives [here](https://github.com/sweatylobster/maxvim).

## Why this repo?

I love home-manager etc, but:

1. I doubt I can always install Nix on a system.
2. I like editing my config and doing `:so %`.

For this reason, I install this configuration like so:

```bash
# In some kind of *.shrc
[ -d "$HOME/.config/maxvim" ] || {
  git clone https://github.com/sweatylobster/nvim ~/.config/maxvim
}
alias maxvim="NVIM_APPNAME=maxvim nvim"
```
