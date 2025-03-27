#!/bin/bash

DOTFILES_DIR=$(git rev-parse --show-toplevel)
source "${DOTFILES_DIR}/src/utils.sh"
CODE_CONFIG="${HOME}/Library/Application Support/Code/User"
CONFIG_HOME="${HOME}/.config"
CALVA_HOME="${CONFIG_HOME}/calva"
KAOCHA_HOME="${CONFIG_HOME}/kaocha"

install_vscode_extension() {
    if [[ $(echo "$CURRENT_CODE_EXTENSIONS" | grep -w "$1") ]]; then
        printf "${NORMAL}%s${GREEN}%s${NORMAL}%s\n" ">> Extension " "$1" " is already installed"
    else
        code --install-extension "$1"
    fi
}

print_title "VSCODE CONFIGURATION"

print_subtitle "Installing VSCODE..."
brew__install "visual-studio-code"

print_subtitle "Installing VSCODE extensions..."
CURRENT_CODE_EXTENSIONS=$(code --list-extensions || echo "")
TARGET_CODE_EXTENSIONS=("adpyke.codesnap"
    "betterthantomorrow.calva"
    "bierner.markdown-mermaid"
    "donjayamanne.githistory"
    "dracula-theme.theme-dracula"
    "eamodio.gitlens"
    "foxundermoon.shell-format"
    "GitHub.copilot"
    "GitHub.copilot-chat"
    "GitHub.vscode-pull-request-github"
    "betterthantomorrow.joyride"
    "k--kato.intellij-idea-keybindings"
    "qezhu.gitlink"
    "redhat.java"
    "redhat.vscode-xml"
    "usernamehw.errorlens"
    "VisualStudioExptTeam.intellicode-api-usage-examples"
    "VisualStudioExptTeam.vscodeintellicode"
    "vscjava.vscode-java-debug"
    "vscjava.vscode-java-dependency"
    "vscjava.vscode-java-pack"
    "vscjava.vscode-java-test"
    "vscjava.vscode-maven"
    "yzhang.markdown-all-in-one")

for extension in "${TARGET_CODE_EXTENSIONS[@]}"; do
    install_vscode_extension "$extension"
done

# Creating symlinks for vscode configuration files
print_subtitle "Creating symlinks for vscode configuration files..."
create_symlink "${DOTFILES_DIR}/src/vscode/resources/settings.json" "${CODE_CONFIG}/settings.json"
create_symlink "${DOTFILES_DIR}/src/vscode/resources/config.edn" "${CALVA_HOME}/"
create_symlink "${DOTFILES_DIR}/src/vscode/resources/keybindings.json" "${CODE_CONFIG}/keybindings.json"
create_symlink "${DOTFILES_DIR}/src/vscode/resources/joyride" "${CONFIG_HOME}"
create_symlink "${DOTFILES_DIR}/src/vscode/resources/tests.edn" "${KAOCHA_HOME/}"
