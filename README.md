# Dothome repo

## Chekout
Checkout using `git clone --recursive <git_url> ~/.dothome` because this repo has some submodules defined:
- gruvbox - Neovim colorscheme
- vim-plug - Neovim package manager

## Nvim setup
### Nvim config
```
cd ~/.dothome
stow nvim
```

### Build nvim for the current user
Because nvim is build in a docker container, the current user must be in the `docker` group
First install the ~/bin folder that contains `install_nvim` sctipt
```
cd ~/.dothome
stow bin
```
You may have to reopen the terminal so `$PATH` variable gets updated

Next, start NVIM builder script:
```
install_nvim
```

Next install the built nvim for the current user:
```
cd ~/.dothome
stow .bld_nvim
```
Next you may have to restart your terminal so `~/.local/bin` is added the `$PATH`
