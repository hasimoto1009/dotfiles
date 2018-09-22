set encoding=utf-8
scriptencoding utf-8
filetype off

if &compatible
  set nocompatible
endif
" Required:
set runtimepath+=~/.vim/dein//repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/dein/')
  call dein#begin('~/.vim/dein/')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('junegunn/vim-easy-align')

  " You can specify revision/branch/tag.
  "call dein#add('Shougo/deol.nvim', { 'rev': 'a1b5108fd' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

filetype plugin on
"ファイル名と内容によてファイルタイプを判別し、ファイルタイププラグインを有効にする
filetype plugin indent on
filetype indent on
runtime macros/matchit.vim " 対応するタグに飛ぶ
syntax enable "色付けをオン
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
let g:ruby_path = "" "補完できなくなりますがかなり高速になる

" ファイルを開いた時、バッファを切替時、 最後にカーソルがあった場所に移動する
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

"Color Schema
"colorscheme solarized
set background=dark
let g:solarized_termcolors=256

set number "行番号表示
set paste "paste mode indentそのままで貼り付ける
set clipboard=unnamed "OSのクリップボードと共有
set tabstop=2
set shiftwidth=2
set expandtab
set cindent "indent type
set virtualedit+=block "矩形選択を行末を超えて選択できるようになる。
set undofile
set undodir=~/.vim/undo/ "UNDOファイルを~/.vim/undoに作成する
set backupdir=~/.vim/backup/
set directory=~/.vim/swap//
set lazyredraw "マクロなどの途中経過を描写しない
set ttyfast "スクロールが遅い問題の解決
set nf="" "<C-a>などの数値増減時に８進数を抜く
set synmaxcol=200 "一行が200文字以上の場合は解析をしないようにする

set scrolloff=3 "3行余裕を持たせてスクロールする
set showmatch " 対応括弧をハイライト表示する
set matchtime=3 " 対応括弧の表示秒数を3秒にする
set wrap " ウィンドウの幅より長い行は折り返され、次の行に続けて表示される

"set columns=175
"set colorcolumn=80
set fdc=2

set ambiwidth=double "全角記号を半角幅で表示してしまう問題の修正
set nostartofline " 移動コマンドを使ったとき、行頭に移動しない
set matchpairs& matchpairs+=<:> " 対応括弧に<と>のペアを追加

set wildmenu wildmode=list:longest,full
set undolevels=300
set history=10000 " コマンド・検索パターンの履歴

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

" カンマ2回でコメントトグル with NERDCommenter
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle


set grepprg=jvgrep
" grep検索のショートカット
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" unite grepにjvgrepを使う
if executable('jvgrep')
    let g:unite_source_grep_command = 'jvgrep'
    let g:unite_source_grep_default_opts = '-r'
    let g:unite_source_grep_recursive_opt = '-R'
endif

"openbrowser
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>

"折り返された行もそのまま移動する
"nnoremap j gj
"nnoremap k gk

" 挿入モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" カーソル前の文字削除
inoremap <silent> <C-h> <C-g>u<C-h>
" カーソル後の文字削除
inoremap <silent> <C-d> <Del>
" カーソルから行頭まで削除
inoremap <silent> <C-d>e <Esc>lc^
" カーソルから行末まで削除
inoremap <silent> <C-d>0 <Esc>lc$
" カーソルから行頭までヤンク
inoremap <silent> <C-y>e <Esc>ly0<Insert>
" カーソルから行末までヤンク
inoremap <silent> <C-y>0 <Esc>ly$<Insert>

"vimrcのエディット
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR>
"vimrcをすぐ読み込む
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
	nnoremap <silent> <Space>rg :<C-u>source $MYGVIMRC<CR>
	let g:previm_enable_realtime = 1
	"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!

"easy align setting
vnoremap <silent> <Enter> :EasyAlign<cr>


"ag setting
" --- type ° to search the word in all files in the current dir
nmap + :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag 


" unite setting
let g:unite_source_history_yank_enable = 1
try
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
" search a file in the filetree
nnoremap <space><space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
" reset not it is <C-l> normally
:nnoremap <space>r <Plug>(unite_restart)
