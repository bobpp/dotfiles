"==============================================================================
" 基本的な設定
"==============================================================================
set nocompatible
set backspace=2

"==============================================================================
" load via Vundle
"==============================================================================
filetype off

set rtp+=~/.vim/vundle/
call vundle#rc()

"==============================================================================
" plugin settings
"==============================================================================

Bundle 'gmarik/vundle'

Bundle 'pig.vim'

Bundle 'pix/Align'
Bundle 'Shougo/neocomplcache'
Bundle 'mileszs/ack.vim'
Bundle 'kana/fakeclip'
Bundle 'mattn/gist-vim'
Bundle 'Shougo/unite.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/rails.vim'
Bundle 'thinca/vim-ref'
Bundle 'mattn/zencoding-vim'
Bundle 'h1mesuke/unite-outline'
Bundle 'motemen/xslate-vim'
Bundle 'cschlueter/vim-wombat'
" Bundle 'perlomni.vim'

"==============================================================================
filetype plugin indent on 
syntax on

"==============================================================================
" color scheme
"==============================================================================
set background=dark
colorscheme wombat 

"==============================================================================
" 検索とか
"==============================================================================
set ignorecase
set smartcase
" grep を vimgrep に固定
set grepprg=internal

"==============================================================================
" tabs/indents
"==============================================================================
set tabstop=4
set shiftwidth=4
set autoindent

"==============================================================================
" デフォルトエンコーディング
"   □とか○の文字があってもカーソル位置がずれないようにする
"   文字コードの自動判別機能は下に記述
"==============================================================================
set encoding=utf-8
set termencoding=utf-8
set fileformats=unix,dos,mac
if exists('&ambiwidth')
  set ambiwidth=double
endif

"==============================================================================
" SwapFile の場所を設定
"==============================================================================
set directory=~/.vim/swap

"==============================================================================
" ステータスライン
"  GetEFstatus() は下に記述
"==============================================================================
set laststatus=2
set statusline=[#%n:%t%m]\ %y\%{GetEFstatus()}%=%l-%c\ %p%%\ \ \ 

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

augroup myfiletypes
	" Clear old autocmds in group
	autocmd!
	" autoindent with two spaces, always expand tabs
	autocmd FileType ruby,eruby,yaml set ai ts=2 sts=0
	autocmd FileType ruby,eruby,yaml highlight tabs ctermbg=7
	autocmd FileType ruby,eruby,yaml match tabs /	/
augroup END

map <F5> :setlocal spell! spelllang=en_us<cr>

"==============================================================================
" Xslate.vim
"==============================================================================
autocmd BufNewFile,BufRead *.xt setfiletype xslate

"==============================================================================
" rubycomplete.vim
"==============================================================================
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

"==============================================================================
" rails.vim
"==============================================================================
let g:rails_level=4
let g:rails_subversion=1
let g:rails_default_file="app/controllers/application.rb"
let g:rails_default_database="sqlite3"

"==============================================================================
" unite.vim
"==============================================================================
let g:unite_enable_start_insert = 1
let g:unite_source_file_mru_time_format = ""
nmap <C-l> :Unite buffer file_mru<CR>

" Unite バッファで <Esc>x2 で終了
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"==============================================================================
" unite-outline.vim
"==============================================================================
nmap <C-o> :Unite outline<CR>

"==============================================================================
" neocomplecache
"==============================================================================
let g:neocomplcache_enable_at_startup = 1

"==============================================================================
" yanktmp.vim
"==============================================================================
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

"==============================================================================
" 日本語文字コードの自動判別
"==============================================================================
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

"ステータスライン表示用
function! GetEFstatus()
  let str = ''
  let fenc = ''
  if &fileformat == 'unix'
    let str = '[UNI]'
  else
    let str = '[' . &fileformat . ']'
  endif
  if &fileencoding != ''
    if &fileencoding =~# 'iso-2022-jp'
      let fenc = 'J'
    elseif &fileencoding == 'utf-8'
      let fenc = 'U'
    elseif &fileencoding == 'cp932'
      let fenc = 'S'
    elseif &fileencoding =~# 'euc-jp'
      let fenc = 'E'
    else
      let fenc = &fileencoding
    endif
    let str = str . '[' . fenc . ']'
  else
    let str = str . '[-]'
  endif
  unlet fenc
  return str
endfunction

" Load .mine ファイル
if filereadable($HOME . '/.vimrc.mine')
  source $HOME/.vimrc.mine
endif

