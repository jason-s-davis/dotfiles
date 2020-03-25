" set leader key
let mapleader =","

" download vim plug if it's missing
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading vim-plug for managing plugins"
	silent !mkdir -p ~/.config/nvim/autoload
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" download plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdtree'
  Plug 'junegunn/goyo.vim'
  Plug 'jreybert/vimagit'
  Plug 'bling/vim-airline'
  Plug 'prettier/vim-prettier'
  " Plug 'sbdchd/neoformat'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'mxw/vim-jsx'
  Plug 'pangloss/vim-javascript'
  Plug 'drewtempelmeyer/palenight.vim'
call plug#end()

" basic config stuff
	set go=a
	set mouse=a
	set nohlsearch
	set clipboard=unnamedplus
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber

	set tabstop=4		" number of visual spaces per tab
	set softtabstop=4	" number of spaces in tab when editing
	set shiftwidth=4	" number of spaces used in autoindent
	set expandtab		" tabs as space characters
	set autoindent		" the same as smarttab?
	set smarttab
	set copyindent		" copy previous line's indent
	set ignorecase		" ignore case in search when typing all lowercase
	set smartcase		" don't ignore case if search term has uppercase

" enable autocompletion
	set wildmode=longest,list,full

" spacebar for search
	map <space> /

" coc settings
	" ctrl f to search files
	map <C-f> :CocList files <Enter>

	" if hidden is not set TextEdit might fail
	set hidden
	set nobackup
	set nowritebackup
	" better message display
	set cmdheight=2

" prettier
	let g:prettier#autoformat = 0
	autocmd BufWritePre *.js,*jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" disable commenting on each new line
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" goyo plugin zoom
	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

" set split behavior to make more sense to me
	set splitbelow splitright

" nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" faster split navigation
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" run file through shellcheck with <leader>s
	map <leader>s :!clear && shellcheck %<CR>

" replace all with S
	nnoremap S :%s//g<Left><Left>

" delete traling whitespace on save
	autocmd BufWritePre * %s/\s\+$//e

" colorscheme
	set background=dark
	colorscheme palenight

	if (has("termguicolors"))
		set termguicolors
	endif

	let g:palenight_terminal_italics=1




" Neoformat
" autocmd BufWritePre,InsertLeave *.js Neoformat
