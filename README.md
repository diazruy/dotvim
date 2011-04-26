# Installation

	git clone git://github.com/diazruy/dotvim.git ~/.vim

Create symlinks
	
	ln -s ~/.vim/vimrc ~/.vimrc

Switch to the ~/.vim directory and fetch submodules

	cd ~/.vim
	git submodule init
	git sumbodule update

## Command-T

Compile command-t

  cd bundle/command-t
  rvm use system # Need to compile with Ruby 1.8
  rake make

## Molokai

For the molokai color scheme

  sudo apt-get install ncurses-term

Add to .bashrc:
    
    export TERM=xterm-256color

## JSLint

For jslint, install node.js

  sudo add-apt-repository ppa:jerome-etienne/neoip 
  sudo apt-get update 
  sudo apt-get install nodejs -y
