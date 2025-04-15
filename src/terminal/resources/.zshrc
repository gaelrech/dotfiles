export GOPATH="${HOME}/go"
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$GOPATH/bin:${PATH}"
export PATH="$HOME/.emacs.d/bin:${PATH}"
export ENABLE_CORRECTION="true"
eval "$(rbenv init -)"
export ZSH="$HOME/.oh-my-zsh"
export GPG_TTY=$TTY
export PINENTRY_USER_DATA="USE_CURSES=1"
export EDITOR=nvim
export VISUAL="code"
JAVA_HOME=$(/usr/libexec/java_home -v 17)
export JAVA_HOME
export JAVA_CMD="${JAVA_HOME}/bin/java"
export NVM_DIR="$HOME/.nvm"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export DEV_DIR="$HOME/dev"
export PERSONAL_DEV_DIR="$DEV_DIR/personal"
export DOTFILES_HOME="$PERSONAL_DEV_DIR/dotfiles"

source "$DOTFILES_HOME/src/utils.sh"

autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

source "$(brew --prefix)/share/antigen/antigen.zsh"

# Antigen setup for oh-my-zsh
antigen use oh-my-zsh

antigen bundle git
antigen bundle aws
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle aubreypwd/zsh-plugin-fd

antigen apply

# External aux functions
source "$HOME/.zsh-functions"
source "$HOME/.zsh-functions-pvt"
source "$HOME/.zsh-aliases"
source "$HOME/.zsh-secrets"

# Fzf
source <(fzf --zsh)
# Starship
eval "$(starship init zsh)"
# Copilot
eval "$(gh copilot alias -- zsh)"

# Disable ZSH auto-correct
unsetopt correct_all

# Homebrew M1+
# --------
if command -v brew >/dev/null; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="${HOMEBREW_PREFIX}/sbin:${PATH}"
fi

# jEnv
# ----
if command -v jenv >/dev/null; then
  export PATH="${HOME}/.jenv/bin:${PATH}"
  eval "$(jenv init -)"
fi

# node
# ----
# https://nodejs.org/api/modules.html
if command -v node >/dev/null && [[ -n "$HOMEBREW_PREFIX" ]]; then
  export NODE_PATH="${HOMEBREW_PREFIX}/lib/node_modules"
fi

source "$HOME/.zshrc-pvt"
