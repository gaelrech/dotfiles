export GOPATH="${HOME}/go"
export PATH="/usr/local/sbin:$PATH"
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="${HOMEBREW_PREFIX}/sbin:${PATH}"
fi
export PATH="$GOPATH/bin:${PATH}"
export PATH="$HOME/.emacs.d/bin:${PATH}"
export PATH="$HOME/.local/bin:$PATH"
export ENABLE_CORRECTION="true"
rbenv() {
  unfunction rbenv
  eval "$(command rbenv init -)"
  rbenv "$@"
}
export ZSH="$HOME/.oh-my-zsh"
export GPG_TTY=$TTY
export PINENTRY_USER_DATA="USE_CURSES=1"
export EDITOR=nvim
export VISUAL="code"
JAVA_HOME=$(/usr/libexec/java_home -v 21)
export JAVA_HOME
export JAVA_CMD="${JAVA_HOME}/bin/java"
export NVM_DIR="$HOME/.nvm"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export DEV_DIR="$HOME/dev"
export PERSONAL_DEV_DIR="$DEV_DIR/personal"
export DOTFILES_HOME="$PERSONAL_DEV_DIR/dotfiles"
export STARSHIP_CONFIG="$HOME/.config/starship/pure.toml"
export TERM=xterm-256color
# Enable Claude Code MCP Tool Search (lazy-loads tool definitions to reduce context usage)
export ENABLE_TOOL_SEARCH=true

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Oh-my-zsh plugins
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::aws

# External plugins
zinit light zsh-users/zsh-autosuggestions
zinit light aubreypwd/zsh-plugin-fd

# Syntax highlighting must be loaded last
zinit light zsh-users/zsh-syntax-highlighting

### End of Zinit's installer chunk

# Fzf
source <(fzf --zsh)
# Starship
eval "$(starship init zsh)"
# Disable ZSH auto-correct
unsetopt correct_all

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


autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
autoload -Uz bashcompinit && bashcompinit

# External aux functions
source "$HOME/.zsh-functions"
source "$HOME/.zsh-functions-pvt"
source "$HOME/.zsh-aliases"
source "$HOME/.zsh-secrets"
source "$HOME/.zshrc-pvt"
source "$DOTFILES_HOME/src/utils.sh"

# Extended history
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt APPEND_HISTORY
setopt SHARE_HISTORY

# Personal scripts
export PATH="$HOME/scripts:$PATH"



# Added by sonarqube-cli installer
export PATH="$HOME/.local/share/sonarqube-cli/bin:$PATH"
