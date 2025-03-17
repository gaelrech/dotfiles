#!/bin/bash

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)
NORMAL='\033[0m'
BREW_LIST=$(brew list)
ARROW='\u2192\n'

source_some () {
    [[ -f "$1" ]] && source "$1"
}

print_title () {
  printf "\n\n${BLUE}%s${NORMAL}\n" "$1"
}

print_subtitle () {
  printf "\n${POWDER_BLUE}%s${NORMAL}\n" "> $1"
}

print_line () {
  printf "${NORMAL}%s${NORMAL}\n" ">> $1"
}

print_already_installed () {
  printf "${NORMAL}%s${GREEN}%s${NORMAL}%s\n" ">> " "$1" " already installed"
}

brew__install () {
    local APP_NAME="$1"
    if [[ $(echo "$BREW_LIST" | grep -w "$APP_NAME") ]]; then
        print_already_installed "$APP_NAME"
    else
        brew install "$APP_NAME"
    fi
}

brew__cask () {
    local CASK="$1"
    if [[ $(echo "$BREW_LIST" | grep -w "$CASK") ]]; then
        print_already_installed "$CASK"
    else
        brew install --cask "$CASK"
    fi
}

create_symlink () {
    local SOURCE="$1"
    local DESTINATION="$2"
    mkdir -p "$DESTINATION"
    ln -sf "$SOURCE" "$DESTINATION"
    printf "${NORMAL}%s${GREEN}%s${NORMAL}%s\n" ">> Symlink " "$(basename "$SOURCE")" " created"
}
