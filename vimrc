set nocompatible

" Enable pathogen
execute pathogen#infect()

" Always show airline & configure it
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#fnamemod = ':t'
function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode',' ','branch'])
    let g:airline_section_b = airline#section#create(['ffenc'])
    let g:airline_section_c = airline#section#create(['%t'])
    let g:airline_section_d = airline#section#create(['filetype'])
    let g:airline_section_x = airline#section#create(['%P'])
    let g:airline_section_y = airline#section#create(['%B'])
    let g:airline_section_z = airline#section#create_right(['%l, %c'])
endfunction
autocmd VimEnter * call AirlineInit()

" Color scheme & syntax highlighting
syntax on
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termcolors = 256
colorscheme solarized

let mapleader="\<Space>"

nnoremap <Leader>w :w<CR>
nnoremap <Leader>- :sp<CR>
nnoremap <Leader>\ :vsp<CR>

" Basic vim options
set backspace=indent,eol,start  " Make backspace key work good
set encoding=utf-8              " Encode UTF-8 by default
set nowrap                      " Don't wrap lines
set noswapfile                  " Disable swap files
set number numberwidth=4        " Enable line numbers (width four)
set ruler                       " Show line and column number of cursor
set scrolloff=3                 " Scroll three lines before top/bottom of view
set showcmd                     " Display incomplete commands
set title                       " Display the file name in the window title
set ttyfast                     " Indicate fast terminal connection

" UI options
set guioptions-=m               " Remove the menu bar
set guioptions-=T               " Remove the toolbar
set guioptions-=L               " Remove the left vertical scroll
set guioptions-=r               " Remove the right vertical scroll

" Folding
set foldenable                  " Enable folding
set foldlevel=99                " Don't close any folds when a file is opened
set foldmethod=syntax           " Fold lines according to source type

" Searching
set hlsearch                    " Enable search highlighting
set incsearch                   " Enable incremental search
set ignorecase                  " Ignore case when searching
set smartcase                   " ... Except when at least one capital

" Whitespace
set textwidth=80                " 80 character text width
set expandtab                   " Expand tabs to spaces
set shiftwidth=2                " Indent = two spaces
set tabstop=2                   " Tab indent = two spaces
set smartindent                 " Indent intelligently
set list                        " Show whitespace chars (next line)
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮

" Use arrow keys to navigate splits
nnoremap <left> <C-w><C-h>
nnoremap <down> <C-w><C-j>
nnoremap <up> <C-w><C-k>
nnoremap <right> <C-w><C-l>

" Escape is too far away
inoremap jk <esc>
inoremap <esc> <nop>
cnoremap jk <esc>
cnoremap <esc> <nop>

" Jump to end/beginning of line
nnoremap H ^
nnoremap L $

" Reselect visual block after indent/outdent -- vimbits.com
vnoremap < <gv
vnoremap > >gv

" Make Y behave like other capitals
map Y y$


" Clear all highlights after incremental search
nnoremap <CR> :noh<CR><CR>

" Word processor mode
func! WordProcessorMode()
    setlocal formatoptions=1
    setlocal noexpandtab
    setlocal spell spelllang=en_us
    set complete+=s
    set formatprg=par
    setlocal wrap
    setlocal linebreak
endfu
com! WP call WordProcessorMode()

" Shortcut to expand scoping braces properly
autocmd FileType c,cpp,objc,objcpp,cs,cuda,java,javascript,rust
  \ ino <buffer> {{ <C-o>o{<CR>}<ESC><Up>o

" C++
augroup C++
autocmd!
autocmd FileType c,cpp iabbrev #i #include
autocmd FileType c,cpp iabbrev #d #define
autocmd FileType c,cpp nno <buffer> <localleader>c I//<esc>
autocmd FileType c,cpp setlocal ts=2 sts=2 sw=2
autocmd FileType c,cpp setlocal cindent
autocmd FileType c,cpp setlocal cinoptions=g0

" Insert include guards when creating a new header file
function! InsertIncludeGuards()
  let guard_name = substitute(expand("%:t"), "\\.", "_", "g")
  let guard_name = "__" . guard_name . "__"
  "normal! o
  execute "normal! i#ifndef " . guard_name
  execute "normal! o#define " . guard_name
  normal! 3o
  execute "normal! Go#endif // " . guard_name
  normal! o
  normal! 3k
endfunc
autocmd BufNewFile *.{h,hpp,hxx} call InsertIncludeGuards()

" Better C++11 syntax highlighting
function! EnhancedCppSyntax()
  syntax clear
  runtime! syntax/cpp.vim

  syntax keyword cpp11Constant      nullptr
  syntax keyword cpp11Type          constexpr override final noexcept
  syntax keyword cpp11StorageClass  decltype
  highlight link cpp11Type          Type
  highlight link cpp11StorageClass  StorageClass
  highlight link cpp11Constant      Constant
endfunc
autocmd BufEnter *.{c,cpp,C,cc,cxx,h,hpp,hxx} call EnhancedCppSyntax()

" Finally, conditionally set Kitware's slightly odd brace style
if $KITWARE_STYLE == '1'
  autocmd FileType c,cpp setlocal cinoptions+={1s
endif

augroup END " C++

" Objective-C/C++
autocmd FileType objc,objcpp setlocal cindent
if $KITWARE_STYLE == '1'
  autocmd FileType objc,objcpp setlocal cinoptions+={1s
endif

" Haskell
augroup Haskell
autocmd!
autocmd FileType haskell setlocal ts=8 sts=4 sw=4
autocmd FileType haskell setlocal expandtab smarttab shiftround nojoinspaces
autocmd FileType haskell nno <buffer> <localleader>c I--<esc>
augroup END

" HTML
augroup HTML
autocmd!
autocmd FileType html setlocal sw=2 ts=2 nowrap
"autocmd BufWritePre,BufRead *.html :normal gg=G
augroup END

" Javascript
augroup JavaScript
autocmd!
autocmd FileType javascript nno <buffer> <localleader>c I//<esc>
augroup END

" Makefiles
augroup Make
autocmd!
autocmd FileType make setlocal noexpandtab
autocmd FileType make nno <buffer> <localleader>c I#<esc>
augroup END

" Markdown
augroup Markdown
autocmd!
autocmd FileType markdown setlocal syntax=off
augroup END

" Python
augroup python
autocmd!
autocmd FileType python setlocal ts=4 sts=4 sw=4 smarttab
autocmd FileType python nnoremap <buffer> <localleader>c I//<esc>
augroup END

" Windows-specific settings
if has("win32") || has("win16")
    autocmdGUIEnter * simalt ~x
    set gfn=Consolas:h12:cANSI
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

