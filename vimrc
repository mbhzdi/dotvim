" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" 	This .vimrc file was originally created by John T. Foster.
" 	It has been modified by Masoud Behzadinasab for his personal use.
" 	Per John's word, while much of it is beneficial for general use, 
" 	it is recommended picking out the parts you want and understand.
"
" }

" Environment {
	" Basics {
		set nocompatible 		" must be first line
        if &shell =~# 'fish$'
            set shell=bash
        endif
        if &shell =~# 'xonsh$'
            set shell=bash
        endif
	" }

" } 

" Bundles {
"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'vim-syntastic/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'dantler/vim-alternate'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-scripts/Align'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'tyru/open-browser.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vim-scripts/jinja'
Plugin 'benmills/vimux'
Plugin 'wincent/command-t'
Plugin 'ervandew/screen'
Plugin 'dag/vim-fish'
Plugin 'rhysd/vim-clang-format'
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'vim-latex/vim-latex'
call vundle#end() 

" }

" Powerline {
    python3 sys.path.append("/home/masoud/.local/lib/python3.6/site-packages/powerline/")
    python3 from powerline.vim import setup as powerline_setup
    python3 powerline_setup()
    python3 del powerline_setup
    let g:Powerline_symbols = 'fancy'
" }

" YCM {
    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" }

" UltiSnips {
    "let g:UltiSnipsExpandTrigger='<c-f>'
    let g:UltiSnipsJumpForwardTrigger='<c-f>'
    let g:UltiSnipsJumpBackwardTrigger='<c-d>'
    inoremap <c-x><c-k> <c-x><c-k>
" }

" vim-clang-format {
    " map to <Leader>cf in C++ code
    autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
    autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
    " Toggle auto formatting:
    nmap <Leader>C :ClangFormatAutoToggle<CR>

    autocmd FileType c,cpp,objc  ClangFormatAutoEnable
" }

" Screen {
    let g:ScreenImpl = 'Tmux'
" }
	
" General {
    set background=dark         " Assume a dark background
    "set background=light       " Assume a light background
    set term=xterm-256color     " Make arrow and other keys work
	syntax on 					" syntax highlighting
    filetype on
	filetype plugin indent on  	" Automatically detect file types.
	set mouse=r					" automatically enable mouse usage
	set encoding=utf-8
	set termencoding=utf-8
	set autowrite                  " automatically write a file when leaving a modified buffer
	set shortmess+=filmnrxoOtT     	" abbrev. of messages (avoids 'hit enter')
	set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
	set virtualedit=onemore 	   	" allow for cursor beyond last character
	set history=1000  				" Store a ton of history (default is 20)
	set spell 		 	        	" spell checking on
	
	" Setting up the directories {
    set backup 						" backups are nice ...
    set backupdir=$HOME/.vimbackup//  " but not when they clog .
    set directory=$HOME/.vimswap// 	" Same for swap files
    set viewdir=$HOME/.vimviews// 	" same for view files
		
    "" Creating directories if they don't exist
    silent execute '!mkdir -p $HOME/.vimbackup'
    silent execute '!mkdir -p $HOME/.vimswap'
    silent execute '!mkdir -p $HOME/.vimviews'
    au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
    au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
	" }
" }

" Vim UI {
	:silent! colorscheme palenight    " load a colorscheme
	set tabpagemax=15 				" only show 15 tabs
	set showmode                   	" display the current mode

	set cursorline  				" highlight current line
	hi cursorline guibg=#333333 	" highlight bg color of current line
	hi CursorColumn guibg=#333333   " highlight cursor

	if has('statusline')
		set laststatus=2           	" show statusline only if there are > 1 windows
	endif

	set backspace=indent,eol,start 	" backspace for dummys
	set linespace=0 				" No extra spaces between rows
	set showmatch                  	" show matching brackets/parenthesis
	set incsearch 					" find as you type search
	set hlsearch 					" highlight search terms
	set winminheight=0 				" windows can be 0 line high 
	set ignorecase 					" case insensitive search
	set smartcase 					" case sensitive when uc present
	set wildmenu 					" show list instead of just completing
	set wildmode=list:longest,full 	" command <Tab> completion, list matches, then longest common part, then all.
	set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
	set scrolljump=5 				" lines to scroll when cursor leaves screen
	set scrolloff=3 				" minimum lines to keep above and below cursor
	set foldenable  				" auto fold code
	set gdefault					" the /g flag on :s substitutions by default

" }

" Line Numbering {
    function! NumberToggle()
        if(&relativenumber == 1)
            set number
        else 
            set relativenumber
        endif
    endfunc

    nnoremap <C-n> :call NumberToggle()<cr>

    set number

    :au FocusLost * :set number
    :au FocusGained * :set number
"    :au FocusGained * :set relativenumber

    autocmd InsertEnter * :set number
    autocmd InsertLeave * :set number
"    autocmd InsertLeave * :set relativenumber

" }

" Formatting {
	set wrap                     	" wrap long lines
	set textwidth=79                " set text length
	set formatoptions=qrn1
	set colorcolumn=80              " creates a color column at column 80
	set autoindent                 	" indent at the same level of the previous line
	set shiftwidth=2               	" use indents of 2 spaces
	set expandtab   	       		    " tabs are  spaces
	set tabstop=2 					        " an indentation every two columns
	set matchpairs+=<:>            	" match, to be used with % 
	set pastetoggle=<F12>          	" pastetoggle (sane indentation on pastes)
	set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" }

" Key Mappings {
	
	"Change the <leader> key
	let mapleader = ","	
	
    "Clear a search
	nnoremap <leader><space> :noh<cr>

	"Allow ; to be the same as :
	nnoremap ; :

	"Map jj to <ESC>
	inoremap jj <ESC>

	"Allow new mapping to split and change to new window
	noremap <leader>w <C-w>v<C-w>l

	"Mapping for Ack
	nnoremap <leader>a :Ack

	"Open NERDTree
	nmap <leader>n :NERDTree<cr>
    let NERDTreeMapOpenInTab='<ENTER?>'

	"Open IPython
	nmap <leader>ip :IPython<cr>
	vmap <leader>ss :ScreenSend<cr>
	
	"Run current file in shell
	nmap <leader>sh :w <cr> :!chmod a+x % && ./%<cr>

	"Open a new tab
	imap <leader>nt <ESC>:tabnew<CR>
	map <leader>nt :tabnew<CR>
	
	" Easier moving in tabs and windows
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

	" Stupid shift key fixes
	cmap W w 						
	cmap WQ wq
	cmap wQ wq
	cmap Q q
	cmap Tabe tabe

	" Yank from the cursor to the end of the line, to be consistent with C and D.
	nnoremap Y y$

	" Shortcuts
	" Change Working Directory to that of the current file
    cmap cwd lcd %:p:h

	" For when you forget to sudo.. Really Write the file.
	cmap w!! w !sudo tee % >/dev/null

	" Fix movement keys
	nnoremap <up> <nop>
	nnoremap <down> <nop>
	nnoremap <left> <nop>
	nnoremap <right> <nop>
	inoremap <up> <nop>
	inoremap <down> <nop>
	inoremap <left> <nop>
	inoremap <right> <nop>
	nnoremap j gj
	nnoremap k gk
	
	" Open .vimrc file in new tab
	nmap <leader>v :tabedit $MYVIMRC<CR>

	" Save on losing focus
	au FocusLost * :wa

    " Copy to clipboard
    vmap <D-x> :!pbcopy<CR>  
    vmap <D-c> :w !pbcopy<CR><CR>
    set clipboard=unnamed


" }

" Code Folding for Markdown {

function! MarkdownLevel(maxlevel)
    if a:maxlevel >= 1 && getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if a:maxlevel >= 2 && getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if a:maxlevel >= 3 && getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if a:maxlevel >= 4 && getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if a:maxlevel >= 5 && getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if a:maxlevel >= 6 && getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
    return "=" 
endfunction

au BufEnter *.md  setlocal foldexpr=MarkdownLevel(2)  
au BufEnter *.md  setlocal foldmethod=expr     
au BufEnter *.md  setlocal autoindent

"}

" GUI Settings {
	" GVIM- (here instead of .gvimrc)
	if has('gui_running')
		set guioptions-=T          	" remove the toolbar
		set lines=40               	" 40 lines of text instead of 24,
        set guifont=Sauce\ Code\ Powerline:h13
	endif
" }

if exists("g:loaded_fix_indentkeys")
    finish
endif

" Fix indentation 
let g:loaded_fix_indentkeys = 1

" Set indentkeys option again on changed filetype option.
" This fixes TeX \item indentation in combination with YouCompleteMe.
" See https://github.com/Valloric/YouCompleteMe/issues/1244
" You may add more filetypes if necessary.
autocmd FileType tex,plaintex execute "setlocal indentkeys=" . &indentkeys
