#環境変数
export LANG=ja_JP.UTF-8

export PATH=$PATH:/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/git/bin
export PATH=$PATH:/usr/sbin

#補完機能を有効にする
autoload  -Uz compinit
compinit

#プロンプトの設定
autoload -Uz colors
colors
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

#大文字と小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#補完候補をウロウロ選ぶ
zstyle ':completion:*:default' menu select=2

#ディレクトリ移動
setopt auto_cd

#cdしたら自動的にpushhdする
setopt auto_pushd

#重複したディレクトリを追加しない
setopt pushd_ignore_dups

#日本語ファイル名を表示可能にする
setopt print_eight_bit

#beepを無効にする
setopt no_beep

#フローコントロールを無効にする
setopt no_flow_control

#Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#'移行をコメントとして扱う
setopt interactive_comments

#beepを無効にする
setopt no_beep

#エイリアス

alias vi=vim
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim'
alias vimdiff=/Applications/MacVim.app/Contents/MacOS/vimdiff
alias view=/Applications/MacVim.app/Contents/MacOS/view

alias la='ls -aF'
alias ll='ls -alF'
alias -g L='| less'
alias -g G='| grep'
alias be='bundle exec '

#グローバルエイリアス
alias -g L='| less'
alias -g G='| ag'

#history設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 前と重複する行は記録しない
setopt HIST_IGNORE_DUPS
# 履歴中の重複行をファイル記録前に無くす
setopt HIST_IGNORE_ALL_DUPS
# 行頭がスペースのコマンドは記録しない
setopt HIST_IGNORE_SPACE
# 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_FIND_NO_DUPS
# 余分な空白は詰めて記録
setopt HIST_REDUCE_BLANKS
# histroyコマンドは記録しない
setopt HIST_NO_STORE

#rbenv
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


[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

#zsh-completionsの追加
fpath=($HOME/.zsh/zsh-completions/src(N-/) $fpath)


#######################################
# go path
########################################
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

########################################
## peco hitory
########################################
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
