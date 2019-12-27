#!/bin/sh

create_dir() {
if [ ! -d $1 ]; then
    mkdir -p $1
fi
}
create_dir ~/.bundle/
create_dir ~/.vim/undo
create_dir ~/.vim/swap
create_dir ~/.vim/backup

if [ ! -x "`which fzf`" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

DOTFILES_DIR=$HOME/dotfiles
ln -sf $DOTFILES_DIR/zshenv $HOME/.zshenv
ln -sf $DOTFILES_DIR/zshrc $HOME/.zshrc
ln -sf $DOTFILES_DIR/gemrc $HOME/.gemrc
ln -sf $DOTFILES_DIR/gitconfig $HOME/.gitconfig
ln -sf $DOTFILES_DIR/gitignore_global $HOME/.gitignore_global
ln -sf $DOTFILES_DIR/ideavimrc $HOME/.ideavimrc
ln -sf $DOTFILES_DIR/railsrc $HOME/.railsrc
ln -sf $DOTFILES_DIR/ripgreprc $HOME/.ripgreprc
ln -sf $DOTFILES_DIR/tigrc $HOME/.tigrc
ln -sf $DOTFILES_DIR/tmux.conf $HOME/.tmux.conf
ln -sf $DOTFILES_DIR/vimrc $HOME/.vimrc
ln -sf $DOTFILES_DIR/bundle_config $HOME/.bundle/config
ln -sfn $DOTFILES_DIR/.zsh $HOME/.zsh

if !(type "cargo" > /dev/null 2>&1); then
  curl https://sh.rustup.rs -sSf | sh
fi

if !(type "diff-highlight" > /dev/null 2>&1); then
  ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

fi

# dein.vim install
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && sh ./installer.sh ~/.vim/dein


if [ ! -x "`which nodenv`" ]; then
  curl -fsSL https://raw.githubusercontent.com/nodenv/nodenv-installer/master/bin/nodenv-installer | bash
fi

git clone --depth 1 https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
