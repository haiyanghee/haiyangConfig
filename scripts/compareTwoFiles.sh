#!/bin/bash
cmp --silent $1 $2 || echo "files are different"
