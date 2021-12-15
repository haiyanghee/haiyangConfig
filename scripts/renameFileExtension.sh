#!/bin/sh

#got from https://unix.stackexchange.com/questions/19654/how-do-i-change-the-extension-of-multiple-files
for f in *$1; do 
    mv -- "$f" "${f%$1}$2"
done
