# Initialize modules
ZIM_HOME=~/.cache/zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

#######################################
# XDG environment variable
#######################################

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_RUNTIME_DIR=/tmp/orbit-"$USER"

export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle/config
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle/cache
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle/plugin

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export NODENV_ROOT="$XDG_DATA_HOME"/nodenv
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export RBENV_ROOT=$XDG_DATA_HOME/rbenv
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/config
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export SOLARGRAPH_CACHE=$XDG_CACHE_HOME/solargraph
export ZIM_HOME=$XDG_CACHE_HOME/zim

#######################################
# environment variable
#######################################

export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export LESSHISTFILE="$XDG_STATE_HOME"/less/history

export PATH=$PATH:/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/git/bin
export PATH="$CARGO_HOME/bin:$PATH"

#######################################
# completion
#######################################

autoload  -Uz compinit && compinit           # 補完機能を有効にする
zstyle ':completion:*:default' menu select=2 # 補完候補をウロウロ選ぶ

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=022'
ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd

#######################################
# option
#######################################

setopt auto_cd              # ディレクトリ移動
setopt auto_pushd           # cdしたら自動的にpushhdする
setopt pushd_ignore_dups    # 重複したディレクトリを追加しない
setopt print_eight_bit      # 日本語ファイル名を表示可能にする
setopt no_beep              # beepを無効にする
setopt no_flow_control      # フローコントロールを無効にする
setopt ignore_eof           # Ctrl+Dでzshを終了しない
setopt interactive_comments # '#'以降をコメントとして扱う

REPORTTIME=1                                 # 実行時間1秒以上のとき、消費時間の統計情報を表示

#######################################
# history setting
#######################################

HISTORY_IGNORE="(ls|ll|pwd)"
HISTSIZE=1000000
SAVEHIST=1000000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' #単語の区切りとみなさない文字

setopt HIST_FIND_NO_DUPS    # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_IGNORE_ALL_DUPS # 履歴中の重複行をファイル記録前に無くす
setopt HIST_IGNORE_DUPS     # 前と重複する行は記録しない
setopt HIST_IGNORE_SPACE    # 行頭がスペースのコマンドは記録しない
setopt HIST_NO_STORE        # histroyコマンドは記録しない
setopt HIST_REDUCE_BLANKS   # 余分な空白は詰めて記録

#######################################
# alias
#######################################

if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
  alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim'
fi
alias v=vim
alias delete-merged-branches='git branch --merged | egrep -v "(^\*|master|staging|production)" | xargs git branch -d'

if type exa > /dev/null 2>&1; then
  alias ls='exa --classify --icons -h --reverse'
  alias ll='exa -al --icons --time-style long-iso'
else
  alias ll='ls -al'
fi
alias grep='rg'
alias be='bundle exec '
alias less='less -Qr'
alias dc_rspec='docker-compose -f docker/development/docker-compose.yml exec -e RAILS_ENV=test app rspec'
alias gs='git status'
alias ga='git add'
alias save='git commit -m'

alias history='history -iD -100'

#グローバルエイリアス
alias -g L='| less'

#######################################
# key bind
# #####################################

bindkey -e

#######################################
# rbenv
#######################################

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

#######################################
# nodenv
#######################################

eval "$(nodenv init -)"

#######################################
# go path
#######################################

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

# zshの起動時間を計測するときに使う
#if (which zprof > /dev/null) ;then
#  zprof | cat
#fi

[ -f $HOME/.config/zsh/.fzf.zsh ] && source $HOME/.config/zsh/.fzf.zsh

# Set Spaceship ZSH as a prompt
eval "$(starship init zsh)"
