#!/bin/bash

#taken from https://stackoverflow.com/questions/1019116/using-ls-to-list-directories-and-their-total-sizes

#this supports hidden files
du -sch * .[!.]* | sort -h
