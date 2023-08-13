#!/bin/sh

echo 'export ZDOTDIR=$HOME/.config/zsh' > $HOME/.zshenv

if !(type "brew" > /dev/null 2>&1); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install readline # irbで日本語入力をするために必要
brew install git      # 最新版をインストール

if !(type "diff-highlight" > /dev/null 2>&1); then
  ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
fi

if !(type "rbenv" > /dev/null 2>&1); then
  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
fi

if [ ! -x "`which nodenv`" ]; then
  curl -fsSL https://raw.githubusercontent.com/nodenv/nodenv-installer/master/bin/nodenv-installer | bash
fi

if !(type "cargo" > /dev/null 2>&1); then
  curl https://sh.rustup.rs -sSf | sh
fi

if [ ! -x "`which fzf`" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

# vim init settings
ln -sf $HOME/.config/vimrc $HOME/.vimrc
mkdir -p  ~/.vim/undo && mkdir -p  ~/.vim/swap && mkdir -p  ~/.vim/backup

# minpac install
git clone --depth 1 https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
