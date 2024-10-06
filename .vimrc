"Plugins
call plug#begin()
    Plug 'tpope/vim-sensible'
    Plug 'morhetz/gruvbox'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'jiangmiao/auto-pairs'
    Plug 'kien/ctrlp.vim'
call plug#end()

set number
set splitright
set nosplitbelow
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab

" Colorscheme
colorscheme gruvbox
set bg=dark
let g:gruvbox_contrast_dark = 'hard'

"For rust syntax highlighting
syntax enable
filetype plugin indent on
let g:rustfmt_autosave = 1

"Key mappings
map <C-b> :NERDTreeToggle<cr>
map <C-ö> :terminal<cr>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
