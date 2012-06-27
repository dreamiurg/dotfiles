syntax on
source /usr/share/vim/google/google.vim
set expandtab
set shiftwidth=2
set softtabstop=2

" perforce commands
command! -nargs=* -complete=file PEdit :!g4 edit %
command! -nargs=* -complete=file PRevert :!g4 revert %
command! -nargs=* -complete=file PDiff :!g4 diff %

function! s:CheckOutFile()
 if filereadable(expand("%")) && ! filewritable(expand("%"))
   let s:pos = getpos('.')
   let option = confirm("Readonly file, do you want to checkout from p4?"
         \, "&Yes\n&No", 1, "Question")
   if option == 1
     PEdit
   endif
   edit!
   call cursor(s:pos[1:3])
 endif
endfunction
au FileChangedRO * nested :call <SID>CheckOutFile()

source /google/src/head/depot/google3/tools/gsearch/contrib/csearch.vim


" use Vim settings, rather then Vi settings (much better!)
" this must be first, because it changes other options as a side effect
set nocompatible


" turn on syntax highlighting
if !exists("syntax_on")
	syntax on
endif

" turn file type detection back on
filetype plugin indent on


"""" Some simple stuff """"""""""""""""""""""""""""""""""""""""""""""""""""""""
set showcmd          " display incomplete commands
set incsearch        " do incremental searching
set hlsearch         " highlight searching results
set number           " show line numbers
set cursorline       " show cursor line
set nowrap           " turn off line wrap
set gdefault         " always global regex
set nobackup         " do not create backup files
set noswapfile       " do not create swap files
set nofoldenable     " turn off folding
set wildmenu         " turn on wildmenu
set wcm=<Tab>        " wildmenu navigation key
set laststatus=2     " status line is always visible
set winminheight=0   " minimum window height (FIXME)
set scrolloff=3      " lines count around cursos
set background=dark  " we want dark and scary interface

" tabulation settings
set smarttab
set autoindent

" allow backspacing over everything in insert mode
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
colorscheme ir_black
