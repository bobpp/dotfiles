"==============================================================================
" 基本的な設定
"==============================================================================
if &compatible
  set nocompatible
endif

"==============================================================================
" load plugins via NeoBundle
"==============================================================================
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
	\ 'build' : {
		\ 'windows' : 'make -f make_mingw32.mak',
		\ 'cygwin' : 'make -f make_cygwin.mak',
		\ 'mac' : 'make -f make_mac.mak',
		\ 'unix' : 'make -f make_unix.mak',
	\ },
\ }
NeoBundle 'pix/vim-align'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'sudo.vim'
NeoBundle 'banyan/recognize_charcode.vim'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

" lang
"" perl
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'motemen/xslate-vim'
NeoBundle 'y-uuki/unite-perl-module.vim'
NeoBundle 'moznion/vim-cpanfile'

"" ruby
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'

"" javascript
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'othree/javascript-libraries-syntax.vim'

"" others
NeoBundle 'motus/pig.vim'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'aklt/plantuml-syntax'

" Theme
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'itchyny/lightline.vim'

call neobundle#end()
filetype plugin indent on 
syntax on

NeoBundleCheck

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
set t_Co=256
set background=dark
colorscheme solarized

"==============================================================================
" ステータスライン
"  GetEFstatus() は下に記述
"==============================================================================
set laststatus=2
let g:lightline = {
\	'colorscheme': 'solarized'
\ }

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
" align
"==============================================================================
let g:Align_xstrlen=3

"==============================================================================
" yanktmp.vim
"==============================================================================
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

"==============================================================================
" javascript-libraries-syntax
"==============================================================================
let g:used_javascript_libs = 'backbone,angularjs,angularui'

"==============================================================================
" Load .mine ファイル
"==============================================================================
if filereadable($HOME . '/.vimrc.mine')
  source $HOME/.vimrc.mine
endif

