#!/bin/sh
DOTFILES_DIR=$HOME/dotfiles
ln -sf $DOTFILES_DIR/zshenv $HOME/.zshenv
ln -sf $DOTFILES_DIR/zshrc $HOME/.zshrc
ln -sf $DOTFILES_DIR/gemrc $HOME/.gemrc
ln -sf $DOTFILES_DIR/gitconfig $HOME/.gitconfig
ln -sf $DOTFILES_DIR/gitignore_global $HOME/.gitignore_global
ln -sf $DOTFILES_DIR/gvimrc $HOME/.gvimrc
ln -sf $DOTFILES_DIR/ideavimrc $HOME/.ideavimrc
ln -sf $DOTFILES_DIR/railsrc $HOME/.railsrc
ln -sf $DOTFILES_DIR/tigrc $HOME/.tigrc
ln -sf $DOTFILES_DIR/vimrc $HOME/.vimrc
ln -sfn $DOTFILES_DIR/.zsh $HOME/.zsh

create_dir() {
if [ ! -d $1 ]; then
    mkdir -p $1
fi
}

create_dir ~/.vim/undo
create_dir ~/.vim/swap
create_dir ~/.vim/backup

# dein.vim install
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && sh ./installer.sh ~/.vim/dein

