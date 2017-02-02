" Xslate
autocmd BufNewFile,BufRead *.xt setfiletype xslate

" Template-Toolkit
autocmd BufNewFile,BufRead *.tt setfiletype tt2html

" .psgi = perl
autocmd BufNewFile,BufRead *.psgi setfiletype perl

" .phps = php
autocmd BufNewFile,BufRead *.phps setfiletype php

" cpanfile
autocmd BufNewFile,BufRead cpanfile set filetype=cpanfile
autocmd BufNewFile,BufRead cpanfile set syntax=perl.cpanfile
