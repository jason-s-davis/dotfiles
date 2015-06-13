
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Vundle (Pathogen) setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Plugin list
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/vundle'

" We could also add repositories with a ".git" extension
"Plugin 'scrooloose/nerdtree.git'

" To get plugins from Vim Scripts, you can reference the plugin
" by name as it appears on the site
"Plugin 'Buffergator'


Plugin 'scrooloose/nerdtree.git'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'mattn/emmet-vim'
Plugin 'skammer/vim-css-color'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'groenewege/vim-less'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'altercation/vim-colors-solarized'
