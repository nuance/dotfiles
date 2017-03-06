#!/bin/bash

mkdir ~/.backup.d
for file in `ls`; do
    if [ "$file" == "install.sh" ] || [ "$file" == "README.md" ] || [ "$file" == "brew_packages" ] || [ "$file" == "intellij-keymap.xml" ] || [ -d "$file" ]; then
        continue
    fi

    if [[ -e ~/.$file ]]; then
        echo "Backing up .$file"
        mv ~/.$file ~/.backup.d/
    fi

    ln -s `pwd`/$file ~/.$file
done

mkdir -p ~/Library/Preferences/IdeaIC2016.3/keymaps
ln -s `pwd`/intellij-keymap.xml ~/Library/Preferences/IdeaIC2016.3/keymaps/

for dir in `ls`; do
    if [ ! -d "$dir" ]; then
        continue
    fi

    if [ "$dir" == "src" ] || [ "$dir" == "pkg" ] || [ "$dir" == "bin" ]; then
        continue
    fi

    if [ "$dir" == "ssh" ] && [ "$1" != "ssh" ]; then
        echo "skipping ssh key setup"
        continue
    fi

    mkdir ~/.$dir
    for file in `ls $dir`; do
        if [[ -e ~/.$dir/$file ]]; then
            echo "Backing up .$dir/$file"
            mv ~/.$dir/$file ~/.backup.d/
        fi

        ln -s `pwd`/$dir/$file ~/.$dir/$file
    done
done
