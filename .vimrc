call plug#begin()

" Language agnostic plugins
Plug 'kien/ctrlp.vim'               " <C-p> to open fuzzy file searcher
Plug 'w0rp/ale'                     " asynchronous linting (Hopefully replacing syntastic)
Plug 'tpope/vim-endwise'            " at least creates end block, maybe more
Plug 'tpope/vim-surround'           " add 's' as a motion for 'surrounding' text object
Plug 'tpope/vim-commentary'         " gc<motion> to comment/uncomment a segment of code | gcc to comment/uncomment a line
Plug 'adelarsq/vim-matchit'         " `%` symbol to move between html open and closing tags (expanding on native vim `%` functionality)
Plug 'jiangmiao/auto-pairs'         " autoclosing braces and adding carriage returns
Plug 'vim-scripts/vim-auto-save'    " autosave files at interval

" Help with git stuff
Plug 'tpope/vim-fugitive'           " NOTES BELOW:
" `:Gedit :Gsplit :Gvsplit :Gtabedit` to edit and stage changes
" `:Gblame` brings up interactive split with `git blame` output
" Does a whole lot more, worth reading at a later time
" Screencasts available at https://github.com/tpope/vim-fugitive

Plug 'airblade/vim-gitgutter'       " show git diff by line numbers

" Frontend plugins
Plug 'pangloss/vim-javascript'      " syntax highlighting and improved indentation
Plug 'mxw/vim-jsx'                  " syntax highlighting and indenting for JSX (depends on 'pangloss/vim-javascript')
Plug 'mattn/emmet-vim'              " <C-y>, to expand html tags etc.

call plug#end()

""""""""""""""""""
" PLUGIN CONFIGS "
""""""""""""""""""

let g:jsx_ext_required=0            " jsx works in js ile
let g:auto_save=1                   " always enable autosave

" ALE settings
" configure fixers
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'javascript': 'eslint'
  \ }
" fix on save
let g:ale_fix_on_save=1

" use the silver searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  " use ag in CtrlP for listing files
  let g:ctrlp_user_command='ag %s -l --no-color -g ""'
  let g:ctrlp_use_Caching=0
endif

colorscheme lucius
LuciusDarkLowContrast

" use emmet for jsx
let g:user_emmet_settings = {
  \   'javascript.jsx': {
  \     'extends': 'jsx',
  \     'quote_char': "'",
  \   },
  \ }

"""""""""
" MISC. "
"""""""""

" Default tab settings
set tabstop=2                       " how many columns a tab counts for (Changes how existing text displays)
set shiftwidth=2                    " how many spaces are inserted when hitting tab button in insert mode
set expandtab                       " inserts spaces when hitting tab

" better folding
set foldmethod=indent               " groups of lines with same indent form a fold
set foldlevel=99                    " makes sure files are 'normal' (not folded) on opening
nnoremap <space> za                 " use space to fold code


" open splits below and to the right
set splitbelow
set splitright

set number relativenumber          " hybrid linenumber mode

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>


"""""""""""""""
" AUTOCMMANDS "
"""""""""""""""

if has("autocmd")
  " au BufRead * normal zR            " Open all folds when opening a new buffer

  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave  * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter    * set norelativenumber
  augroup END

  " on save, source the current file
  augroup vimrc
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif

"""""""""""""""
" KEYMAPPINGS "
"""""""""""""""

inoremap jk <Esc>

" Better navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
