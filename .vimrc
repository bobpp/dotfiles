"==============================================================================
" 基本的な設定
"==============================================================================
if &compatible
  set nocompatible
endif

" reset augroup
augroup ResetAutoCmd
  autocmd!
augroup END

"==============================================================================
" load plugins via Dein.vim
"==============================================================================
" dein settings {{{
" 0. neovim / vim configure
if has('nvim') " neovim
  let s:dein_dir = empty($XDG_CACHE_HOME) ? expand('~/.cache/nvim/dein') : $XDG_CACHE_HOME . '/nvim/dein'
  let s:dein_plugin_toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
  let s:dein_lazy_plugin_toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein_lazy.toml'
else " vim
  let s:dein_dir = empty($XDG_CACHE_HOME) ? expand('~/.cache/vim/dein') : $XDG_CACHE_HOME . '/vim/dein'
  let s:dein_plugin_toml_file = fnamemodify(expand('<sfile>'), ':h').'/.vim/dein.toml'
  let s:dein_lazy_plugin_toml_file = fnamemodify(expand('<sfile>'), ':h').'/.vim/dein_lazy.toml'
endif

" 1. auto dein.vim install
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" 2. dein configure
let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1

" 3. plugin configures
if has('nvim')
  if empty($XDG_CACHE_HOME)
    set runtimepath+=~/.cache/nvim/dein/repos/github.com/Shougo/dein.vim
  else
    set runtimepath+=$XDG_CACHE_HOME/nvim/dein/repos/github.com/Shougo/dein.vim
  endif
else 
  if empty($XDG_CACHE_HOME)
    set runtimepath+=~/.cache/vim/dein/repos/github.com/Shougo/dein.vim
  else
    set runtimepath+=$XDG_CACHE_HOME/vim/dein/repos/github.com/Shougo/dein.vim
  endif
endif
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:dein_plugin_toml_file, { 'lazy': 0 })
  call dein#load_toml(s:dein_lazy_plugin_toml_file, { 'lazy': 1 })
  call dein#end()
  call dein#save_state()
endif


" 4. plugin auto install
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax on


" }}}

"==============================================================================
" Basic Setting
"==============================================================================
set backspace=2
set nobackup
nnoremap : ;
nnoremap ; :
set nowildmenu
set wildmode=longest,list:longest

"==============================================================================
" color scheme
"==============================================================================
let g:solarized_termcolors=16
set background=dark
colorscheme solarized

"==============================================================================
" ステータスライン
"==============================================================================
set laststatus=2
set noshowmode
let g:lightline = { 'colorscheme': 'solarized' }

"==============================================================================
" 検索とか
"==============================================================================
set ignorecase
set smartcase
set grepprg=internal "grep を vimgrep に固定

"==============================================================================
" tabs/indents
"==============================================================================
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

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai ts=2 sts=2 shiftwidth=2 expandtab
augroup END

au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

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
"	unite-outline.vim
"==============================================================================
let g:unite_enable_start_insert = 1
let g:unite_source_file_mru_time_format = ""
let g:unite_source_file_mru_limit = 500
nnoremap <C-l> :Unite buffer file_mru<CR>
nnoremap <C-i> :Unite buffer file_rec/git<CR>
nnoremap <C-o> :Unite outline<CR>

" Unite バッファで <Esc>x2 で終了
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" search via grep
nnoremap <C-k>           :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,<C-k> :<C-u>UniteResume search-buffer<CR>

" search by pt
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --follow'
  let g:unite_source_grep_recursive_opt = ''
endif

"==============================================================================
" neocomplete
"==============================================================================
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

"==============================================================================
" neosnippet
"==============================================================================
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
let g:neosnippet#snippets_directory="~/.vim/snippets"

"==============================================================================
" Load .mine ファイル
"==============================================================================
if filereadable($HOME . '/.vimrc.mine')
  source $HOME/.vimrc.mine
endif

