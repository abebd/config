set directory^=$LOCALAPPDATA/vim/swap//
set backupdir^=$LOCALAPPDATA/vim/backup//
set undodir^=$LOCALAPPDATA/vim/undo//
set viminfofile=$LOCALAPPDATA/vim/viminfo

call plug#begin()
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-fugitive'
    Plug 'mileszs/ack.vim'
    Plug 'inkarkat/vim-ingo-library'
    
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'dense-analysis/ale'

	"themes
	Plug 'LuRsT/austere.vim'
    Plug 'morhetz/gruvbox'
    Plug 'sainnhe/gruvbox-material'
    Plug 'joshdick/onedark.vim'
	Plug 'kvrohit/rasmus.nvim'
    Plug 'ayu-theme/ayu-vim'
    Plug 'EdenEast/nightfox.nvim'
    Plug 'tomasr/molokai'
    Plug 'ayu-theme/ayu-vim' 
    Plug 'nordtheme/vim'
    Plug 'olimorris/onedarkpro.nvim'
call plug#end()

" choose theme
let s:theme_file = expand('~/.config/global_theme')

if filereadable(s:theme_file)
    let g:active_theme = trim(readfile(s:theme_file)[0])
else
    let g:active_theme = "gruvbox" " Fallback
endif

" Apply logic based on the string
if g:active_theme == "onedark"
    colorscheme onedark
elseif g:active_theme == "gruvbox"
    colorscheme gruvbox
    set bg=dark
    let g:gruvbox_contrast_dark = 'dark'
    let g:gruvbox_material_foreground = 'material'
endif
 
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
set ffs=unix,dos

" --@gui/
set guifont=Consolas:h14
set guioptions-=m
set guioptions-=T
set guioptions=Ace
set encoding=utf-8
set fileencoding=utf-8
set nowrap
set autoindent

let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:ale_set_quickfix = 0
let g:ale_set_loclist = 1

let g:ale_linters = {
\   'python': ['ruff'],
\}
let g:ale_fixers = {
\   'python': ['ruff'],
\}

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi EndOfBuffer ctermbg=NONE guibg=NONE
hi LineNr ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE


filetype plugin indent on
let g:rustfmt_autosave = 1
 

let g:mapleader=','

map <C-w><C-b> :buffers<cr>
map <C-ö> :terminal<cr>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

nnoremap <Leader>b :ls<cr>:b<space>
nnoremap <Leader>t :Tags<enter>
nnoremap <Leader>y :BTags<enter>
let g:NERDTreeWinPos = "right"

" <S-Tab>: completion back
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<C-H>"
" <CR>: confirm completion, or insert <CR>
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
 
function! Check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction
let g:startify_bookmarks = [ {'c': '~/.vimrc'}, {'x': '/h/docs/notes.txt'}]

"nnoremap <Space><Space> :!vim -o $(fzf)<CR>

function! OpenFilesFromFzfInPwd()
  let tempfile = tempname()
  "call system('find . -type f | fzf --multi > ' . shellescape(tempfile))
  call system('find . -type f -not -path "*/.git/*" -not -path "*/__pycache__/*" -not -path "*.swp" -not -path "*/.vs/*" | fzf --multi > ' . shellescape(tempfile))
  let files = readfile(tempfile)
  if empty(files)
    return
  endif
  call delete(tempfile)

  let files = map(files, 'substitute(v:val, "^\\./", "", "")')
  execute 'edit' fnameescape(files[0])
  for file in files[1:]
    execute 'badd' fnameescape(file)
  endfor
endfunction

function! RgFzfOpen()
    let dir = expand('%:p:h')
    let result = systemlist('rg --line-number "" ' . dir . ' | fzf')[0]
    if result != ''
        let parts = split(result, ':')
        execute 'edit ' . parts[0]
        execute parts[1]
    endif
endfunction

nnoremap <leader>rf :call RgFzfOpen()<CR>

" custom fzf thing
"nnoremap <Space><Space> :call OpenFilesFromFzfInPwd()<CR>

"nnoremap <Space><Space> :Files <CR>
nnoremap <Space><Space> :FZF <CR>

function! ToggleQuickfix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction

nnoremap <leader>c :call ToggleQuickfix()<CR>

function! GetFunctionsInFile()

    cexpr []

    let l:ft = &filetype

    let l:patterns = {
                \ 'python': '^def\s\+',
                \ 'javascript': '^\s*function\s\+',
                \ 'typescript': '^\s*function\s\+',
                \ 'c': '^\s*\(\w\+\s\+\)\?\w\+\s*(.*)\s*{',
                \ 'cpp': '^\s*\(\w\+\s\+\)\?\w\+\s*(.*)\s*{',
                \ 'vim': '^function\s\+',
                \ 'lua': '^function\s\+',
                \ 'ps1': '^function\s\+'
                \ }
    
    let l:pattern = get(l:patterns, l:ft, '^function')

	execute 'vimgrep /' . l:pattern . '/j %'

	copen
endfunction

nnoremap <leader>gf :call GetFunctionsInFile()<CR>

" Add all conflicted files to quickfix, safely handling spaces
function! GitConflictsQuickfix()
    " Get list of conflicted files from Git (null-separated to handle spaces)
    let l:files = split(system("git diff --name-only --diff-filter=U -z "), "\0")

    if empty(l:files)
        echo "No conflicted files."
        return
    endif

    " Build quickfix list
    let l:qf = []
    for f in l:files
        " Skip empty entries (happens because of trailing null)
        if f == ''
            continue
        endif
        " Add entry at line 1, column 1; text empty for now
        call add(l:qf, {'filename': f, 'lnum': 1, 'col': 1, 'text': ''})
    endfor

    " Set quickfix list and open it
    call setqflist(l:qf)
    copen
endfunction

command! GitConflicts call GitConflictsQuickfix()
command! PyBuild cexpr system('uv run basedpyright') | copen

" ack.vim --- {{{

" Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:ackprg = 'rg --vimgrep'

" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>/ so we're ready to type the search keyword
" nnoremap <Leader>/ :Ack!<Space>
nnoremap <Leader>f :Ack!<Space>
nnoremap <Leader>* :execute 'Ack! ' . expand('<cword>')<CR>
" }}}

" Navigate quickfix list with ease
nnorema <Leader>w :cprevious<CR>
nnoremap <Leader>s :cnext<CR>

" +  Add the current file to the buffer list, and go to the next file entry.
"function! NetrwBufAdd(isLocal)
    "let l:filespec = netrw#Call('NetrwFile', netrw#Call('NetrwGetWord'))
    "if filereadable(l:filespec)
        "execute 'badd' ingo#compat#fnameescape(l:filespec)
    "endif
    "execute 'normal!' (b:netrw_liststyle == netrw#Expose('WIDELIST') ? 'W' : 'j')
    "return ''
"endfunction
"
"" -  Remove file buffer if it exists
"function! NetrwBufRemove(isLocal)
    "let l:filespec = netrw#Call('NetrwFile', netrw#Call('NetrwGetWord'))
    "let l:buf = bufnr(fnameescape(l:filespec))
    "if l:buf > 0
        "execute 'bdelete' l:buf
    "endif
    "execute 'normal!' (b:netrw_liststyle == netrw#Expose('WIDELIST') ? 'W' : 'k')
    "return ''
"endfunction
"
"let g:Netrw_UserMaps = [
"\   ['<Tab>', 'NetrwBufAdd'],
"\   ['<S-Tab>', 'NetrwBufRemove'],
"\]

" Add current file to buffer list and move to next entry
function! NetrwBufAdd(isLocal)
  try
    let l:filespec = netrw#Call('NetrwFile', netrw#Call('NetrwGetWord'))
    if filereadable(l:filespec)
      execute 'badd' ingo#compat#fnameescape(l:filespec)
    else
      echohl WarningMsg | echom "Not a readable file: " . l:filespec | echohl None
    endif
  catch /.*/
    echohl ErrorMsg | echom "Error adding file: " . v:exception | echohl None
  endtry

  " Move cursor to next entry
  try
    execute 'normal!' (b:netrw_liststyle == netrw#Expose('WIDELIST') ? 'W' : 'j')
  catch /.*/
    " Ignore movement errors silently
  endtry
  return ''
endfunction

" Remove current file buffer (if it exists) and move to next entry
function! NetrwBufRemove(isLocal)
  try
    let l:filespec = netrw#Call('NetrwFile', netrw#Call('NetrwGetWord'))
    let l:buf = bufnr(fnameescape(l:filespec))
    if l:buf > 0
      execute 'bdelete' l:buf
    else
      echohl WarningMsg | echom "Buffer not found for: " . l:filespec | echohl None
    endif
  catch /.*/
    echohl ErrorMsg | echom "Error removing buffer: " . v:exception | echohl None
  endtry

  " Move cursor to next entry
  try
    execute 'normal!' (b:netrw_liststyle == netrw#Expose('WIDELIST') ? 'W' : 'k')
  catch /.*/
    " Ignore movement errors silently
  endtry
  return ''
endfunction

" Use Tab and Shift-Tab to add/remove buffers
let g:Netrw_UserMaps = [
\   ['<Tab>', 'NetrwBufAdd'],
\   ['<S-Tab>', 'NetrwBufRemove'],
\]

" --@main-end/

