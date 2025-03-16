#!/bin/bash


CONFIG_DIR=$(git rev-parse --show-toplevel)
source "${CONFIG_DIR}/src/utils.sh"

print_title "GENERAL APPLICATIONS"

install_with_brew "obsidian"
install_with_brew "google-drive"
install_with_brew "meetingbar"
install_with_brew "hiddenbar"
install_with_brew "notion"
install_with_brew "spotify"
