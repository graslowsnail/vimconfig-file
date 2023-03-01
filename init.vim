call plug#begin("~/.vim/plugged")
"Plugin section
  Plug 'pangloss/vim-javascript'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  " Using Vim-Plug:
   "Plug 'Mofiqul/dracula.nvim'
  Plug 'NLKNguyen/papercolor-theme'

  " Linter
  Plug 'dense-analysis/ale'

  " file tree plugin
  Plug 'preservim/nerdtree'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
    
Plug 'mhinz/vim-signify'

" tree sitter makes it more colorful
Plug 'nvim-treesitter/nvim-treesitter'
" icons
  Plug 'ryanoasis/vim-devicons'
  

call plug#end()

let g:deoplete#enable_at_startup = 1
" let g:ale_completion_enabled = 1

syntax enable

colorscheme PaperColor

" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

filetype on
set autoindent
set expandtab
set shiftwidth=4
set showmatch


" SET NERD TREE toggle TO CTRL + N
nnoremap <C-n> :NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

autocmd VimEnter * TSEnable highlight
" number lines
" turn relative line numbers on
" turn hybrid line numbers on
set number relativenumber
set nu rnu



