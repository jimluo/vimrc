jimluo's vimrc
============
Author: jimluo <luojinlj@gmail.com>

Thanks:
  jimluo. https://github.com/jimluo/vimrc.
  gimv win32 http://code.google.com/p/vim-for-win-with-ruby/
  macvim https://github.com/b4winckler/macvim

ONE-STEP INSTALL
----------------

Use curl (for Mac OS X):

     curl -o - https://raw.github.com/jimluo/vimrc/master/auto-install.sh | sh

or wget (for most UNIX platforms):

     wget -O - https://raw.github.com/jimluo/vimrc/master/auto-install.sh | sh


MANUALLY INSTALL
----------------

1. Check out from github

        git clone git://github.com/jimluo/vimrc.git ~/.vim
        cd ~/.vim
        git submodule update --init

2. Install ~/.vimrc and ~/.gvimrc

        ./install-vimrc.sh

3. (Optional, if you want Command-T) Compile the Command-T plugin

        cd .vim/bundle/command-t/ruby/command-t
        ruby extconf.rb
        make

MANUALLY INSTALL ON WINDOWS
---------------------------

1. Check out from github

        cd C:\Program Files\Vim   (or your installed path to Vim)
        rmdir /s vimfiles         (This deletes your old vim configurations. If you want to keep it, use move instead of rmdir.)
        git clone git://github.com/jimluo/vimrc.git vimfiles
        git submodule update --init

2. Install vimrc. Add the following line at the end of C:\Program Files\Vim\vimrc.

        source $VIM/vimfiles/vimrc


  
INSTALL & UPGRADE PLUGIN BUNDLES
--------------------------------

All plugins were checked out as git submodules, 
which can be upgraded with `git pull`. For example, to upgrade Command-T 

     cd ~/.vim/bundle/command-t
     git pull

To install a new plugin as a git submoudle, type the followin commands.

     cd ~/.vim
     git submodule add [GIT-REPOSITORY-URL] bundle/[PLUGIN-NAME]

HOW TO USE
----------

see the "USEFUL SHORTCUTS" section in vimrc to learn my shortcuts.

