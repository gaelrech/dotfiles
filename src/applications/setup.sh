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
