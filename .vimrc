" --@changelog/
" 	when		what
"   2025-03-18  add expandtab
"	2025-02-21	new schemes
"	2024-11-19	new scheme and other shit
"	2024-10-09	tab auto complete
"	2024-10-06	added ctrlp.vim
"	2024-10-03	initial commit
" --@changelog-end/
" --@main/
" --@plugins/
call plug#begin()
    Plug 'tpope/vim-sensible'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'jiangmiao/auto-pairs'
    Plug 'kien/ctrlp.vim'
    Plug 'mhinz/vim-startify'

	"themes
	Plug 'LuRsT/austere.vim'
    Plug 'morhetz/gruvbox'
    Plug 'sainnhe/gruvbox-material'
    Plug 'joshdick/onedark.vim'
	Plug 'davidosomething/vim-colors-meh'
	Plug 'kvrohit/rasmus.nvim'
    Plug 'ayu-theme/ayu-vim'
call plug#end()
 
set number
set splitright
set nosplitbelow
set relativenumber
set tabstop=4
set shiftwidth=4
set belloff=all
set paste "allow copy paste
set autoindent
set scrolloff=5
set expandtab
set ignorecase
"colorcolumn stuff
"doesnt work
"set colorcolumn=80
"autocmd WinLeave * set colorcolumn=0
"autocmd WinEnter * set colorcolumn=80
"hi ColorColumn ctermbg=grey

let g:coc_disable_startup_warning = 1

" --@gui/

set guifont=Consolas:h14
set guioptions-=m
set guioptions-=T
set guioptions=Ace
 
" --@colorschemes/


"colorscheme gruvbox
"set bg=dark
"let g:gruvbox_contrast_dark = 'hard'
"let g:gruvbox_material_foreground = 'material'
 
"colorscheme meh
"colorscheme onedark
colorscheme ayu

"For rust syntax highlighting
syntax enable
filetype plugin indent on
let g:rustfmt_autosave = 1
 
" DISABLED: Plug doesnt work with powershell
"let &shell = executable('powershell') ? 'pwsh' : 'powershell'
"let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
"let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
"let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
"set shellquote= shellxquote=

" --@key mappings/
map <C-w><C-b> :buffers<cr>
map <C-�> :terminal<cr>
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
let g:startify_bookmarks = [ {'c': '~/.vimrc'}, {'x': '/h/docs/notes.txt'}]
" --@main-end/
