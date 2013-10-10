call pathogen#infect()
set number                      " Show line numbers
set nohlsearch                  " turn off highlighting for searched expressions
set incsearch                   " highlight as we search however
set matchtime=5                 " blink matching chars for .x seconds
set ignorecase                  " set case insensitivity
set smartcase                   " unless there's a capital letter
set completeopt=menu,longest,preview " more autocomplete <Ctrl>-P options
set nostartofline               " leave my cursor position alone!
set backspace=2                 " equiv to :set backspace=indent,eol,start
set showmatch                   " show matching brackets
autocmd BufReadPre,BufNewFile SConstruct set filetype=python
autocmd BufReadPre,BufNewFile SConscript set filetype=python
syntax on
set autoindent                  " set the cursor at same indent as line above
set smartindent                 " try to be smart about indenting (C-style)
set tw=0                        " Stop wrapping my fucking lines kthx
set expandtab                   " expand <Tab>s with spaces; death to tabs!
set shiftwidth=4                " spaces for each step of (auto)indent
set softtabstop=4               " set virtual tab stop (compat for 8-wide tabs)
set tabstop=4                   " for proper display of files with tabs
set shiftround                  " always round indents to multiple of shiftwidth
set copyindent                  " use existing indents for new indents
set preserveindent              " save as much indent structure as possible
filetype plugin indent on       " load filetype plugins and indent settings

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
