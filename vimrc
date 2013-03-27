"==============================================================================
" 基本的な設定
"==============================================================================
set nocompatible

"==============================================================================
" load plugins via NeoBundle
"==============================================================================
filetype off

if has('vim_starting')
	set rtp+=~/.vim/neobundle/
endif
call neobundle#rc(expand('~/.vim/bundle'))

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'pig.vim'
NeoBundle 'pix/vim-align'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'mattn/gist-vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tpope/vim-rails'
NeoBundle 'thinca/vim-ref'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'motemen/xslate-vim'
NeoBundle 'cschlueter/vim-wombat'
NeoBundle 'Shougo/vimproc'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'ssh://bobpp@a-chan.bobpp.jp/home/bobpp/git/TT2-syntax.vim.git'
NeoBundle 'sudo.vim'
NeoBundle 'banyan/recognize_charcode.vim'
NeoBundle 'javascript.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle "y-uuki/unite-perl-module.vim"
NeoBundle 'tpope/vim-markdown'

"==============================================================================
" Basic Setting
"==============================================================================
set backspace=2
filetype plugin indent on 
syntax on

"==============================================================================
" color scheme
"==============================================================================
set background=light
colorscheme solarized

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
"==============================================================================
set encoding=utf-8
set termencoding=utf-8
set fileformats=unix,dos,mac
if exists('&ambiwidth')
  set ambiwidth=double
endif

"==============================================================================
" ステータスライン
"  GetEFstatus() は下に記述
"==============================================================================
set laststatus=2
let &statusline='[#%n:%t%m] %y%{GetEFstatus()} %{fugitive#statusline()}%=%l-%c %p%%   '

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
let g:unite_source_file_mru_limit = 500
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
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_plugin_rank = {}

"==============================================================================
" yanktmp.vim
"==============================================================================
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

"==============================================================================
" ステータスライン表示用
"==============================================================================
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

"==============================================================================
" Load .mine ファイル
"==============================================================================
if filereadable($HOME . '/.vimrc.mine')
  source $HOME/.vimrc.mine
endif

