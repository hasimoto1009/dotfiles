#######################################
# environment variable
#######################################

export LANG=ja_JP.UTF-8

export PATH=$PATH:/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/git/bin
export PATH=$PATH:/usr/sbin

#補完機能を有効にする
autoload  -Uz compinit && compinit

#######################################
# prompt
#######################################

autoload -Uz colors && colors
PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})[%n@%m]%{${reset_color}%}[%~] %# "
#vcs_infoを右に表示
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' formats '%F{green}(%s)[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)[%b|%a]%f'
zstyle ':vcs_info:git:*' check-for-change true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "-"
zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'

function _update_vcs_info_msg() {
  LANG=en_US.UTF-8 vcs_info
  RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

zstyle ':completion:*:default' menu select=2 #補完候補をウロウロ選ぶ

REPORTTIME=1 ## 実行時間1秒以上のとき、消費時間の統計情報を表示

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

alias vi=vim
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim'
alias vimdiff=/Applications/MacVim.app/Contents/MacOS/vimdiff
alias view=/Applications/MacVim.app/Contents/MacOS/view

alias la='ls -aF'
alias ll='ls -alF'
alias be='bundle exec '

alias history='history -iD -100'

#グローバルエイリアス
alias -g L='| less'
alias -g G='| ag'

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
# go path
#######################################

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

#######################################
## peco hitory
#######################################

autoload -Uz zmv
alias zmv='noglob zmv -W'
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# zshの起動時間を計測するときに使う
#if (which zprof > /dev/null) ;then
#  zprof | cat
#fi
