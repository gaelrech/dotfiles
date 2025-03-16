#!/bin/bash

CONFIG_DIR=$(git rev-parse --show-toplevel)
source "${CONFIG_DIR}/src/utils.sh"

HOTKEYS_PLIST="${HOME}/Library/Preferences/com.apple.symbolichotkeys.plist"

mac__disable_keybinding(){
  plutil -replace AppleSymbolicHotKeys."$1".enabled -bool false "${HOTKEYS_PLIST}"
}

print_title "MAC CONFIGURATION"

print_subtitle "Removing default keybindings..."
# Mission Control
mac__disable_keybinding 32
mac__disable_keybinding 33
# Show Desktop (F11)
mac__disable_keybinding 36
# Spotlight/Finder
mac__disable_keybinding 64
mac__disable_keybinding 65
