#!/bin/sh
DOTFILES_DIR=$HOME/dotfiles
ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc
ln -sfn $DOTFILES_DIR/.zsh $HOME/.zsh
ln -sf $DOTFILES_DIR/.gemrc $HOME/.gemrc
ln -sf $DOTFILES_DIR/.gitconfig $HOME/.gitconfig
ln -sf $DOTFILES_DIR/.gitignore_global $HOME/.gitignore_global
ln -sf $DOTFILES_DIR/.gvimrc $HOME/.gvimrc
ln -sf $DOTFILES_DIR/.ideavimrc $HOME/.ideavimrc
ln -sf $DOTFILES_DIR/.railsrc $HOME/.railsrc
ln -sf $DOTFILES_DIR/.tigrc $HOME/.tigrc
ln -sf $DOTFILES_DIR/.vimrc $HOME/.vimrc
