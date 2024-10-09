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

" <Tab>: completion
inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-N>" :
    \ Check_back_space() ? "\<Tab>" :
    \ coc#refresh()
" <S-Tab>: completion back
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<C-H>"
" <CR>: confirm completion, or insert <CR>
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

function! Check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

