filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set nocompatible
set modelines=0

syntax on

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

"""" Some simple stuff """"""""""""""""""""""""""""""""""""""""""""""""""""""""
set cursorline       " show cursor line
set hidden
set incsearch        " do incremental searching
set laststatus=2     " status line is always visible
set nobackup         " do not create backup files
set nofoldenable     " turn off folding
set noswapfile       " do not create swap files
set nowrap           " turn off line wrap
set number           " show line numbers
set ruler

set relativenumber
set scrolloff=3      " lines count around cursos
set showcmd          " display incomplete commands
set showmode
set ttyfast
set visualbell
set wcm=<Tab>        " wildmenu navigation key
set wildmenu         " turn on wildmenu
set winminheight=0   " minimum window height (FIXME)

let mapleader = ","
nnoremap / /\v\c
vnoremap / /\v\c
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>


" ,<space> will clear search highlight
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
" strip all trailing whitespace on ,W
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" tabulation settings
set smarttab
set autoindent

" allow backspacinddg over everything in insert mode
set backspace=indent,eol,start

" set file encodings
set encoding=utf-8
set fileencodings=utf8,cp1251

" set global list of ignores files
set wildignore+=.git,*.o,*.pyc,.DS_Store

" chars for fill statuslines and vertical separators
set fillchars=vert:\ ,fold:-

" chars for showing inwisible symbols
" set listchars=tab:>>,eol:$,trail:.


"""" Statusline setup """""""""""""""""""""""""""""""""""""""""""""""""""""""""
" active statusline
function! SwitchToBuffer()
	if &buftype != 'quickfix' && &buftype != 'nofile'
		if exists("*GitBranchInfoTokens")
			let &l:statusline = "%<%f\ %m%r\ %{GitBranchInfoTokens()[0]}\%=\ %Y\ \|\ %{&fenc==\"\"?&enc:&fenc}\ \|\ %{&ff}\ \|\ %l,%v\ %P"
		lse
			let &l:statusline = "%<%f\ %m%r\%=\ %Y\ \|\ %{&fenc==\"\"?&enc:&fenc}\ \|\ %{&ff}\ \|\ %l,%v\ %P"
		endif
		wincmd _
	endif
endfunction
autocmd BufEnter * call SwitchToBuffer()
autocmd WinEnter * call SwitchToBuffer()

" inactive statusline
autocmd WinLeave * let &l:statusline = '%<%f'

" gvim colorscheme
colorscheme Tomorrow-Night-Bright

set t_Co=256
