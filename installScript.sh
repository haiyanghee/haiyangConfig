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
