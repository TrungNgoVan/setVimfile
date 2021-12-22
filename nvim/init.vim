set nu
set mouse=a 				" Enable mouse
set tabstop=4 				" 
set shiftwidth=4 			" 
set listchars=tab:\¦\ 		" Tab charactor 
set list
set foldmethod=indent 		" 
set foldlevelstart=99 		"  
set number 					" Show line number
set ignorecase 				" Enable case-sensitive 
"new
set relativenumber
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set showcmd
set showmatch
set encoding=utf-8
set encoding=UTF-8
set hlsearch
set smartindent
set autoindent
set inde
set paste
"end new
" Disable backup
set nobackup
set nowb
set noswapfile
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
syntax on

" Enable copying from vim to clipboard
if has('win64')
	set clipboard=unnamed  
else
	set clipboard=unnamedplus
endif

" Auto reload content changed outside
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
		\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
			\ | checktime 
		\ | endif
autocmd FileChangedShellPost *
		\ echohl WarningMsg 
		\ | echo "File changed on disk. Buffer reloaded."
		\ | echohl None
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Resize pane
nmap <M-Right> :vertical resize +1<CR> 		
nmap <M-Left> :vertical resize -1<CR>
nmap <M-Down> :resize +1<CR>
nmap <M-Up> :resize -1<CR>
nmap <silent> <F5> :NERDTreeToggle<CR>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Search a hightlighted text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin list
" (used for Vim-plug - https://github.com/junegunn/vim-plug)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(stdpath('config').'/plugged')
	Plug 'Chiel92/vim-autoformat'
" Theme 					" Dark theme
	Plug 'pineapplegiant/spaceduck'
" File browser
	Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
	Plug 'preservim/nerdTree' 						" File browser  
	Plug 'Xuyuanp/nerdtree-git-plugin' 				" Git status
	Plug 'ryanoasis/vim-devicons' 					" Icon
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'unkiwii/vim-nerdtree-sync' 				" Sync current file 
" File search
	Plug 'junegunn/fzf', 
		\ { 'do': { -> fzf#install() } } 			" Fuzzy finder 
	Plug 'junegunn/fzf.vim'
" Status bar
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
" Terminal
	Plug 'voldikss/vim-floaterm' 					" Float terminal
" Code intellisense
	Plug 'neoclide/coc.nvim', {'branch': 'release'} " Language server 
	Plug 'jiangmiao/auto-pairs' 					" Parenthesis auto 
	Plug 'alvan/vim-closetag'
	Plug 'mattn/emmet-vim' 
	Plug 'preservim/nerdcommenter' 					" Comment code 
	Plug 'liuchengxu/vista.vim' 					" Function tag bar 
	Plug 'alvan/vim-closetag' 						" Auto close HTML/XML tag 
" Code syntax highlight
	Plug 'yuezk/vim-js' 							" Javascript
	Plug 'MaxMEllon/vim-jsx-pretty' 				" JSX/React
	Plug 'jackguo380/vim-lsp-cxx-highlight'			" C++ syntax
	Plug 'uiiaoo/java-syntax.vim' 					" Java
" Debugging
	Plug 'puremourning/vimspector' 					" Vimspector
" Source code version control 
	Plug 'tpope/vim-fugitive' 						" Git
call plug#end()
"Prettier CLi Path
let g:prettier#exec_cmd_path="/home/dungtv/.vim/autoload/vim-prettier/node_modules/.bin/prettier"
nnoremap <C-p> :Prettier<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Background
"...
"Indent display
let g:indent_guides_enable_on_vim_startup = 1
if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
endif
colorscheme spaceduck
"Overwrite some color highlight 
if (has("autocmd"))
	augroup colorextend
		autocmd ColorScheme 
			\ * call onedark#extend_highlight("Comment",{"fg": {"gui": "#728083"}})
		autocmd ColorScheme 
			\ * call onedark#extend_highlight("LineNr", {"fg": {"gui": "#728083"}})
	augroup END
endif
" Disable automatic comment in newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
"Setting for nerdtree
autocmd StdinReadPre * let s:std_in=1
"Exit Vim if there no file more
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
nnoremap <leader>n :NEARTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeMapOpenInTab='<ENTER>'
let g:prettier#exec_cmd_path="/home/dungtv/.vim/autoload/vim-prettier/node_modules/.bin/prettier"
nnoremap <C-p> :Prettier<CR>
" Other setting
for setting_file in split(glob(stdpath('config').'/settings/*.vim'))
	execute 'source' setting_file
endfor


