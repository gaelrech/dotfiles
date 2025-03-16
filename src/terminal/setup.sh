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

print_subtitle "App installation"
install_with_brew "zsh"
install_with_brew "font-fira-code-nerd-font"
install_with_brew "starship"
install_with_brew "fzf"
install_with_brew "jq"
install_with_brew "xq"
install_with_brew "bat"
install_with_brew "antigen"
install_with_brew "coreutils"
install_with_brew "k9s"
install_with_brew "shellcheck"
install_with_brew "gnupg"
install_with_brew "ripgrep"
install_oh_my_zsh

# Git
install_with_brew "gh"
install_with_brew "lazygit"
gh extension install dlvhdr/gh-dash
gh extension install github/gh-copilot

# Clojure
install_with_brew "clojure"
install_with_brew "leiningen"
install_with_brew "jet"
install_with_brew "babashka"

print_subtitle "Creating symlinks for zsh configuration files"
create_symlink "${CONFIG_DIR}/src/terminal/resources/.zshrc" "$HOME/.zshrc"
create_symlink "${CONFIG_DIR}/src/terminal/resources/.zsh-aliases" "$HOME/.zsh-aliases"
create_symlink "${CONFIG_DIR}/src/terminal/resources/.zsh-functions" "$HOME/.zsh-functions"
create_symlink "${CONFIG_DIR}/src/terminal/resources/starship.toml" "$HOME/.config/starship.toml"
create_symlink "${CONFIG_DIR}/src/terminal/resources/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
