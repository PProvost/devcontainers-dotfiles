# devcontainers-dotfiles

My own dotfiles, meant to be used with devcontainers and, therefore, made with simplicity in mind.

Based on https://github.com/matheusfvesco/devcontainers-dotfiles/

## Features

The install script **DELETES** the `~/.zshrc`, `~/.aliases`, `~/bin` and `~/.config/starship.toml` files and directories from your home directory, and replaces them with symlinks to this repository's dotfiles. It also changes the default shell to zsh.

Currently, it contains:
* **.zshrc**: sources both .aliases and .aliases.local if present, and runs starship at the end of the file.
* **.aliases**: aliases for common commands (e.g., `alias mkdir="mkdir -pv"`)
* **.config/starship.toml**: a Starship config i like to use, with my own modifications.
* **plugins**: [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting), [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete), and [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) plugins.
* **bin folder**: a folder with some useful scripts I use in my projects (e.g., `bin/mklinks.sh`, for linking the container mounts to the project folder).
* **.gitconfig**: some git aliases I prefer

All of the files are created as symbolic links.
plugins are cloned inside `~/.zsh_addons/`.

A `~/.aliases.local` file can be used to add your own project/system specific aliases.

## Installation

Just copy the following lines to your user settings json:

```
{
    "containers.dotfiles.repository": "https://github.com/PProvost/devcontainers-dotfiles.git",
    "containers.dotfiles.targetPath": "~/dotfiles",
}
```

or if you use Remote-SSH or Remote-Tunnels:

```
{
    "remote.containers.dotfiles.repository": "https://github.com/PProvost/devcontainers-dotfiles.git",
    "remote.containers.dotfiles.targetPath": "~/dotfiles",
}
```
