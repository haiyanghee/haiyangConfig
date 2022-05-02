#!/bin/bash
#https://stackoverflow.com/questions/2507766/merge-convert-multiple-pdf-files-into-one-pdf

#<merged.pdf> <file1> <file2> 
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -o $@ ; 

# apparantly this should result in smaller size but it doesn't ...
#gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -o $@ ; 
