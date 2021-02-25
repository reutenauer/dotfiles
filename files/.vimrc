syntax on
set hlsearch
set incsearch

set backup
set backupdir=$HOME/.vim/backup,.,/tmp
set directory=$HOME/.vim/backup,.,/tmp

set shiftwidth=2
set expandtab
set autoindent
set smartindent

let botdirname=substitute(execute("pwd"), '^.*/', '', '')
" let branchname=execute("!git branch | grep -E '^\*' | cut -c 3-")
" %F: full path to file, %y: file type, %O: file byte position (hexadecimal),
" %B: byte value (hexadecimal), %n: buffer number
set rulerformat=%48(%F,%y,%O,u:%B,b:%n,%{botdirname}%)
set ruler

" TODO Make development-only
set number

let l=getline('.')
let c=v:char

set showmatch

function s:current_word()
  return getline('.')[searchpos('\s', 'nb')[1] : searchpos('\s', 'n')[1]-2]
endfunction

function! s:grepcurword()
  " echo("foo")
  grep -r s:current_word() .
endfunction

map Y s:grepcurword()

function Currword()
  return s:current_word()
endfunction

function Grcw()
  return s:grepcurword()
endfunction
