#!/bin/bash


CONFIG_DIR=$(git rev-parse --show-toplevel)
source "${CONFIG_DIR}/src/utils.sh"

print_title "GENERAL APPLICATIONS"

brew__install "obsidian"
brew__install "google-drive"
brew__install "hiddenbar"
brew__install "spotify"
brew__cask "raycast"
brew__cask "istat-menus"
brew__cask "notion-calendar"
brew__cask "claude-code"
brew__cask "cursor"
brew__cask "ghostty"
brew__cask "cmux"
brew__cask "notion"
brew__cask "intellij-idea-ce"
brew__cask "kitty"
brew__cask "hyper"
brew__cask "zen-browser"
brew__cask "gitify"
brew__cask "mutedeck"

# Fonts
brew__cask "font-jetbrains-mono"
brew__cask "font-anka-coder"
brew__cask "font-symbols-only-nerd-font"
