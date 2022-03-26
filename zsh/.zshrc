#######################################
# XDG environment variable
#######################################

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

#######################################
# environment variable
#######################################

export LANG=ja_JP.UTF-8

export PATH=$PATH:/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/git/bin
export PATH=$PATH:/usr/sbin
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.nodenv/shims:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export LESSCHARSET=utf-8
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
#######################################
# completion
#######################################

autoload  -Uz compinit && compinit           # 補完機能を有効にする
zstyle ':completion:*:default' menu select=2 # 補完候補をウロウロ選ぶ

fpath=(~/.zsh/src $fpath)

if [ -f ~/.zsh/zsh-autosuggestions.zsh ]; then
  source ~/.zsh/zsh-autosuggestions.zsh
fi

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

HISTFILE=~/.zsh_history
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
alias -g G='| jvgrep'

#######################################
# key bind
# #####################################

bindkey -e

#######################################
# rbenv
#######################################

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
function gem(){
  $HOME/.rbenv/shims/gem $*
  if [ "$1" = "install" ] || [ "$1" = "i" ] || [ "$1" = "uninstall" ] || [ "$1" = "uni" ]
  then
    rbenv rehash
  fi
}

function bundle(){
  $HOME/.rbenv/shims/bundle $*
  if [ "$1" = "install" ] || [ "$1" = "update" ]
  then
    rbenv rehash
  fi
}

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

#export RUBYOPT="-w"
# Set Spaceship ZSH as a prompt
eval "$(starship init zsh)"
