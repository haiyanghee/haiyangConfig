#!/bin/sh

configDir=.config
curDir=$(pwd)
echo "current directory is: $curDir"
mkdir -p ~/.config

#symlink configs
for entry in "$configDir"/*
do
  echo "ln -s "$curDir/$entry" "$HOME/.config""
  ln -s "$curDir/$entry" "$HOME/.config" 
done

#link scripts
ln -s "$curDir/scripts" "$HOME/.scripts" 

cp "$curDir/.bashrc" "$HOME/.bashrc" 
#cp "$curDir/.xinitrc" "$HOME/.xinitrc" 

#symlink the dot files
#manually resolve the errors..
find -maxdepth 1 -type f -name ".*" -execdir ln -s "$(realpath {})" "$HOME/{}" \;
