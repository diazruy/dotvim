" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Debian turns filetype on automatically before it calls pathogen
" causing problems with cucumber
filetype off

" Package bundling using pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

runtime! macros/matchit.vim

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup    " do not keep a backup file, use versions instead
set noswapfile
set history=50    " keep 50 lines of command line history
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands

" Search
set incsearch     " do incremental searchingA
set ignorecase    " case insensitive search
set smartcase     " case insensitive when lowe case, else case sensitive

set rnu        " show relative line numbers
set nu         " show current line number instead of 0
set cursorline    " Highlight current row
set laststatus=2  " Always show statusline

" Tabs and indentation
set softtabstop=2 " Set tab width to 2
set shiftwidth=2  " Set tab width to 2
set tabstop=2     " Set tab width to 2
set expandtab     " Insert tabs as spaces

set nowrap        " Disable text wrapping
set wildignore=*/log/*,*.cache,*.gif,*.png,*.jpg,*.orig,*~,*.scssc " Ignore these file from listings
"set autoread      " Load file changes outside of vim

let g:localvimrc_whitelist='/home/ruy/projects/\(rewportal\).*'
" Remap leader
let mapleader=","

syntax enable
set background=dark
colorscheme solarized

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Ctrl-P to display Tree browser (C-P was previously mapped to k)
nmap <leader>n :NERDTreeToggle<CR>
" ,p to show current file in the tree
nmap <leader>p :NERDTreeFind<CR>
" Close NERDTree when opening a file
let NERDTreeQuitOnOpen=1

" Ctrl-N to disable search match highlight
" Note: C-N was the same as k (move to next line )
nmap <silent> <C-N> :noh<CR>

" ,/ to invert comment on the current line/selection
nmap <leader>/ :call NERDComment(0, "invert")<cr>
vmap <leader>/ :call NERDComment(0, "invert")<cr>

" Navigate splits without having to prepend with C-w
nmap <C-h> <C-w>h
nmap <C-k> <C-w>k
nmap <C-j> <C-w>j
nmap <C-l> <C-w>l

" Center search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
nnoremap <silent> G Gzz

" Split creation
nnoremap vv :vsplit<CR>
nnoremap ss :split<CR>
set splitbelow
set splitright

" Navigate between tabs
nmap <Leader>[ :tabp<CR>
nmap <Leader>] :tabn<CR>

" Bubble single lines
nnoremap <C-Up> [e
nnoremap <C-Down> ]e
" Bubble multiple lines
vnoremap <C-Up> [egv
vnoremap <C-Down> ]egv

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" DelimitMate override of SnipMate's S-Tab
imap <S-Tab> <Plug>delimitMateS-Tab

" Map Ctrl-S to save
noremap <silent> <C-S> <Esc>:Update<CR>

" Copy/Paste to system clipboard
vmap <leader>c "+yv"zy`>
nmap <leader>v "+p

" Set JavaScript runtime for JSLint
let $JS_CMD='node'

" Tagbar
nnoremap <Leader>rt :TagbarToggle<CR>

" Save as sudo with w!!
cmap w!! w !sudo tee % >/dev/null

" Move cursor while in insert mode without using arrow keys
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" Map :vimgrep to leader-f
nmap <leader>f :vimgrep

" Map upper case to lower case
nmap :W :w
nmap :E :e
nmap :Q :q

" Xmpfilter to evaluate Ruby inline
nmap <buffer> <F5> <Plug>(xmpfilter-run)
xmap <buffer> <F5> <Plug>(xmpfilter-run)
imap <buffer> <F5> <Plug>(xmpfilter-run)

nmap <buffer> <F4> <Plug>(xmpfilter-mark)
xmap <buffer> <F4> <Plug>(xmpfilter-mark)
imap <buffer> <F4> <Plug>(xmpfilter-mark)

" Show Git diff in window split when committing
autocmd FileType gitcommit DiffGitCached | wincmd p

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  autocmd BufNewFile,BufRead *.thor set filetype=ruby
  autocmd BufNewFile,BufRead *.js.hbs set filetype=html
  autocmd BufNewFile,BufRead Guardfile set filetype=ruby
  autocmd BufNewFile,BufRead Gemfile set filetype=ruby
  autocmd BufNewFile,BufRead Rakefile set filetype=ruby
  autocmd BufNewFile,BufRead *.arb set filetype=ruby
  autocmd BufNewFile,BufRead *.scss set filetype=sass
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufNewFile,BufRead *.hjs set filetype=handlebars

  autocmd FocusGained * call s:UpdateNERDTree()

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif

  if exists(":CommandTFlush") == 2
    CommandTFlush
  endif
endfunction

" Removes trailing spaces
function <SID>TrimWhiteSpace()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  :retab
  let @/=_s
  call cursor(l, c)
endfunction

set list listchars=trail:.,extends:>
autocmd BufWritePre * :call <SID>TrimWhiteSpace()

" Include local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"Include project vim config
if filereadable(expand("./.vimrc.custom"))
  source ./.vimrc.custom
endif

" Include Gary Bernhardt's testing shortcuts
source ~/.vim/testing
