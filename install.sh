#!/bin/sh

# Check if zsh is installed and do nothing if not
if ! command -v zsh >/dev/null 2>&1; then
  echo "zsh is not installed. Please install zsh and rerun this script."
  exit 1
fi

# Get the path of zsh
ZSH_PATH=$(which zsh)

PLUGINS_DIR="$HOME/.zsh_addons"
BIN_DIR="$HOME/bin"

# Get the directory of the script
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Remove existing symlinks/files if they exist
echo "Removing existing dotfiles if they exist..."
rm -f "$HOME/.aliases"
rm -f "$HOME/.zshrc"
rm -f "$HOME/.config/starship.toml"
rm -f "$HOME/.gitconfig"

# Remove plugins directory if it exists
if [ -d "$PLUGINS_DIR" ]; then
  echo "Plugins directory ($PLUGINS_DIR) already exists. Removing it..."
  rm -rf "$PLUGINS_DIR"
fi

# Creates root directories if they don't exist
echo "Creating necessary directories..."
mkdir -p "$HOME/.config"
mkdir -p "$PLUGINS_DIR"

# Create symlinks for the dotfiles, overwriting if they exist
echo "Creating symlinks for dotfiles..."
ln -sf "$SCRIPT_DIR/.aliases" "$HOME/.aliases"
ln -sf "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$SCRIPT_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

# Remove bin directory if it exists
if [ -d "$BIN_DIR" ] || [ -L "$BIN_DIR" ]; then 
  echo "Bin ($BIN_DIR) already exists. Removing it..."
  rm -rf "$BIN_DIR"
fi
# Create a symlink for the bin directory
ln -s "$SCRIPT_DIR/bin" "$BIN_DIR"

git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "$PLUGINS_DIR/zsh-autocomplete"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting "$PLUGINS_DIR/fast-syntax-highlighting"

# Install starship
echo "Installing starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Change the default shell to zsh if not already set
if [ "$SHELL" != "$ZSH_PATH" ]; then
  echo "Changing default shell to zsh..."
  sudo chsh -s "$ZSH_PATH" "$(whoami)"

  # Check if the shell was changed successfully
  if [ $? -eq 0 ]; then
    echo "Successfully changed the default shell to zsh."
    echo "Please log out and log back in for the changes to take effect."
  else
    echo "Failed to change the default shell."
    exit 1
  fi
else
    echo "Default shell is already zsh."
fi
