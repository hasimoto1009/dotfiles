set encoding=utf-8
scriptencoding utf-8
filetype off

" For a paranoia.
" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

if exists('*minpac#init')
  " minpac is loaded.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Add other plugins here.
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('Shougo/neosnippet.vim')
  call minpac#add('Shougo/neosnippet-snippets')
  call minpac#add('junegunn/vim-easy-align')
  call minpac#add('jparise/vim-graphql')
  call minpac#add('tpope/vim-endwise', { 'on_ft': 'ruby' }) " filetypeがrubyの時有効
  call minpac#add('ctrlpvim/ctrlp.vim')
  call minpac#add('vim-ruby/vim-ruby')
  call minpac#add('joker1007/vim-ruby-heredoc-syntax')
  call minpac#add('mattn/benchvimrc-vim')
  call minpac#add('vim-ruby/vim-ruby')
  call minpac#add('tpope/vim-projectionist')
  call minpac#add('tpope/vim-rbenv')
  call minpac#add('tpope/vim-bundler')
  call minpac#add('vim-scripts/vim-airline')
  call minpac#add('andymass/vim-matchup')
  call minpac#add('matsub/github-actions.vim')
endif

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
packadd minpac

filetype plugin on
"ファイル名と内容によてファイルタイプを判別し、ファイルタイププラグインを有効にする
filetype plugin indent on
filetype indent on
runtime macros/matchit.vim " 対応するタグに飛ぶ
syntax enable "色付けをオン
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
let g:ruby_path = "" "補完できなくなりますがかなり高速になる

if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif
" ファイルを開いた時、バッファを切替時、 最後にカーソルがあった場所に移動する
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

autocmd QuickFixCmdPost *grep* cwindow

set list
set listchars=tab:»-
"Color Schema
"colorscheme solarized
set background=dark

" === vim-ruby-heredoc-syntax ===
" Add syntax rule
let g:ruby_heredoc_syntax_defaults = {
\ "graphql" : {
\   "start" : "GRAPHQL",
\ },
\ "json" : {
\   "start" : "JSON",
\ },
\ "sql" : {
\   "start" : "SQL",
\ },
\ "markdown" : {
\   "start" : "MD",
\ },
\}

set number "行番号表示
"set paste "paste mode indentそのままで貼り付ける
set clipboard=unnamed "OSのクリップボードと共有
set tabstop=2
set shiftwidth=2
set expandtab
set cindent "indent type
set virtualedit+=block "矩形選択を行末を超えて選択できるようになる。
set undofile
set undodir=~/.vim/undo/ "UNDOファイルを~/.vim/undoに作成する
set backupdir=~/.vim/backup/
set directory=~/.vim/swap/
set lazyredraw "マクロなどの途中経過を描写しない
set ttyfast "スクロールが遅い問題の解決
set nf="" "<C-a>などの数値増減時に８進数を抜く
set synmaxcol=200 "一行が200文字以上の場合は解析をしないようにする

set hidden "ファイル編集中でもバッファを切り替えられるようにする

set scrolloff=3 "3行余裕を持たせてスクロールする
set showmatch " 対応括弧をハイライト表示する
set matchtime=3 " 対応括弧の表示秒数を3秒にする
set wrap " ウィンドウの幅より長い行は折り返され、次の行に続けて表示される

set re=1

set ruler
set colorcolumn=80,120
highlight ColorColumn ctermbg=17
set fdc=2
set hlsearch
hi Search ctermbg=LightYellow

autocmd QuickFixCmdPost *grep* cwindow

set ambiwidth=double "全角記号を半角幅で表示してしまう問題の修正
set nostartofline " 移動コマンドを使ったとき、行頭に移動しない
set matchpairs& matchpairs+=<:> " 対応括弧に<と>のペアを追加

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildmenu wildmode=list:longest,full
set undolevels=300
set history=10000 " コマンド・検索パターンの履歴
set signcolumn=yes

" powerline setting
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noequalalways
"set guifont=RictyDiscord-RegularForPowerline:h14
"set guifont=SauceCodePowerline-Regular

let g:indentLine_faster = 1

if executable('rg') "ripgrep
  set grepprg=rg\ --vimgrep
  let g:ctrlp_user_command = ['.git', 'cd %s; rg --files-with-matches ".*"', 'find %s -type f']
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" 検索時、検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz # :h * で確認
nnoremap g# g#zz

" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>

nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR> " vimrcのエディット
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR> " vimrcをすぐ読み込む

vnoremap <silent> <Enter> :EasyAlign<cr>

nnoremap <silent> <C-j> :bprev<CR> "1つ前のバッファに切り替え
nnoremap <silent> <C-k> :bnext<CR> "1つ後のバッファに切り替え

" go get github.com/mattn/files
let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
let g:ctrlp_use_caching = 0
let g:ctrlp_root_markers = ['Gemfile', 'pom.xml', 'build.xml']
let g:ctrlp_max_height = 20 
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|vendor)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" ale settings 
let g:ale_fixers = { 'ruby': ['rubocop'] }
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
highlight ALEWarning ctermbg=88
