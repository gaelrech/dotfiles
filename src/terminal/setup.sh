#!/bin/bash

CONFIG_DIR=$(git rev-parse --show-toplevel)
source "${CONFIG_DIR}/src/utils.sh"

install_oh_my_zsh () {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        print_already_installed "Oh-my-zsh!"
    else
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
}

print_title "TERMINAL CONFIGURATION"

print_subtitle "Installing binaries..."
brew__install "zsh"
brew__install "font-fira-code-nerd-font"
brew__install "starship"
brew__install "fzf"
brew__install "jq"
brew__install "xq"
brew__install "bat"
brew__install "antigen"
brew__install "coreutils"
brew__install "k9s"
brew__install "shellcheck"
brew__install "gnupg"
brew__install "ripgrep"
install_oh_my_zsh

# Fonts
print_subtitle "Installing Fonts..."
brew__cask "font-jetbrains-mono-nerd-font"

# Git
print_subtitle "Installing Git..."
brew__install "gh"
brew__install "lazygit"
gh extension install dlvhdr/gh-dash
gh extension install github/gh-copilot

# Clojure
print_subtitle "Installing Clojure..."
brew__install "clojure"
brew__install "leiningen"
brew__install "jet"
brew__install "babashka"

# Go
print_subtitle "Installing Go..."
brew__install "go"
mkdir -p ~/go/{bin,pkg,src}
go env -w GOPATH="$HOME/go"

print_subtitle "Creating symlinks for zsh configuration files..."
create_symlink "${CONFIG_DIR}/src/terminal/resources/.zshrc" "$HOME/.zshrc"
create_symlink "${CONFIG_DIR}/src/terminal/resources/.zsh-aliases" "$HOME/.zsh-aliases"
create_symlink "${CONFIG_DIR}/src/terminal/resources/.zsh-functions" "$HOME/.zsh-functions"
create_symlink "${CONFIG_DIR}/src/terminal/resources/starship" "$HOME/.config/"
create_symlink "${CONFIG_DIR}/src/terminal/resources/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

# ITerm 2
print_subtitle "Installing Iterm2..."
brew__cask "iterm2"
create_symlink "${CONFIG_DIR}/src/terminal/resources/com.googlecode.iterm2.plist" "$HOME/.config/iterm2/"
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/.config/iterm2"
