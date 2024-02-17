
" number lines
" turn relative line numbers on
" turn hybrid line numbers on
set number relativenumber

" clipboard copying command c
set clipboard+=unnamedplus

set nu rnu
set completeopt-=preview
set encoding=UTF-8
set splitright
filetype on
set autoindent
set expandtab
set shiftwidth=4
set showmatch
set nocompatible

" do not wrap lines. 
set nowrap

" open new split panes to right and below
set splitbelow

":h hl-CursorLineNr

call plug#begin()
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  "Plug 'neoclide/coc.nvim', {'branch': 'release'}


  Plug 'sheerun/vim-polyglot'
  "Plugin section
  Plug 'pangloss/vim-javascript'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'morhetz/gruvbox' 
  Plug 'NLKNguyen/papercolor-theme'

  "CSS Color Preview
  Plug 'https://github.com/ap/vim-css-color' 
  " Linter
  Plug 'dense-analysis/ale'
  " file tree plugin
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'

  Plug 'Shougo/deoplete-lsp'
  Plug 'neovim/nvim-lspconfig'

"deopleate auto complete
if has('nvim')
 Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

let g:deoplete#enable_at_startup =1

Plug 'maxmellon/vim-jsx-pretty'
    
Plug 'mhinz/vim-signify'
" tree sitter makes it more colorful
" Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
" We recommend updating the parsers on update
" icons
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
call plug#end()

syntax enable

" enable line numbers for nerd tree
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used - nerdtree
autocmd FileType nerdtree setlocal relativenumber
" Removes the ? in nerd Tree
"let NERDTreeMinimalUI = 1

" limits the number of items shows on auto complete
set pumheight=6

"status line settings
set statusline+=\ %F\ %M\ %Y\ %R
set statusline+=%=
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%

" highlight current cursor line number
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline

"colorscheme PaperColor
colorscheme gruvbox

" turn terminal to normal mode with escape
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" open terminal on ctrl+x
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction

" open terminal on the bottom
nnoremap <C-x> :call OpenTerminal()<CR>

" SET NERD TREE toggle TO CTRL + N
nnoremap <C-n> :NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


" automaticly turn on tree sitter highlight
autocmd VimEnter * TSEnable highlight

" show ignored files for gitStatus in nerd tree
let g:NERDTreeGitStatusShowIgnored = 1 " a heavy feature may cost much more time. default: 0

" customize icons for gitStatus in nerd tree
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✚',
                \ 'Staged'    :'✹',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }



lua << EOF
require'lspconfig'.tsserver.setup{
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gs', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end
}
EOF

au BufRead,BufNewFile *.tsx set filetype=typescriptreact
au BufRead,BufNewFile *.jsx set filetype=javascriptreact

