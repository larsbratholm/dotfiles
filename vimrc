
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Leader
let mapleader=","

if !has('gui_running')
  set t_Co=256
endif


" ----------------------------------------
" https://github.com/junegunn/vim-plug
" ----------------------------------------


filetype off


call plug#begin()
" PlugInstall
" PlugUpgrade
" PlugClean!

" python folding
Bundle 'tmhedberg/SimpylFold'


" let Plug manage Vundle
" Plug 'gmarik/vundle'


" Supertab: Use tab for code completion
" https://github.com/ervandew/supertab
" Plug 'ervandew/supertab'

" Linting, fixing, completion and more
Plug 'w0rp/ale'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_sign_warning = '▴'
let g:ale_sign_error = 'X'
" Clear the background colors of ALe
highlight link ALEWarningSign String
highlight link ALEErrorSign Title
" removed fortran support until i find solution
let g:ale_linters = {
    \   'fortran': [],
    \   'python': [],
    \}


" underscore is too common a false-positive error
" for urls and files
let tex_no_error=1

" completer
" snippets

" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Track custom snippets
" reads ~/.vim/snippets automatic

" Theme Plug
Plug 'flazz/vim-colorschemes'
Plug 'nanotech/jellybeans.vim'
Plug 'tomasiser/vim-code-dark'


" L9
" Dependency for a lot of plugins
Plug 'vim-scripts/L9'


" Line Numbers
" https://github.com/myusuf3/numbers.vim
Bundle 'myusuf3/numbers.vim'

" TComment
" https://github.com/tomtom/tcomment_vim
"
" Handles commenting of multiple lines
"    gc{motion}   :: Toggle comments (for small comments within one line 
"                    the &filetype_inline style will be used, if 
"                    defined)
"    gc<Count>c{motion} :: Toggle comment text with count argument 
"                    (see |tcomment#Comment()|)
"    gcc          :: Toggle comment for the current line
"    gC{motion}   :: Comment region
"    gCc          :: Comment the current line
"
" In visual mode:
"    gc           :: Toggle comments
"    gC           :: Comment selected text
Plug 'tomtom/tcomment_vim'


" Bottomline
Plug 'itchyny/lightline.vim'
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'component': {
	\   'readonly': '%{&readonly?"x":""}',
	\ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' }
	\ }

" Indentation lines
" usage: <leader>ig
Plug 'nathanaelkane/vim-indent-guides'

" keep vim sessions - not sure if automatic
Plug 'tpope/vim-obsession'


" Auto ident
Plug 'ldx/vim-indentfinder'

call plug#end()



" ---------------
" Navigation
" ---------------

" Turn off linewise keys. This is especially important when working with word
" wrap documents
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

function EnableDisplayWrapping()
  if !&wrap
	setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction

function DisableDisplayWrapping()
  if &wrap
    setlocal nowrap
    nunmap <buffer> <Up>
    nunmap <buffer> <Down>
    iunmap <buffer> <Up>
    iunmap <buffer> <Down>
    vunmap <buffer> <Up>
    vunmap <buffer> <Down>
  endif
endfunction


" NOTE: "C-tab", does not work in terminals,
" because terminals does not support it
" and will just send "tab" instead.
"nnoremap <C-S-tab> :tabprevious<CR>
"nnoremap <C-tab>   :tabnext<CR>
"nnoremap <C-t>     :tabnew<CR>
"inoremap <C-S-tab> <Esc>:tabprevious<CR>i
"inoremap <C-tab>   <Esc>:tabnext<CR>i
"inoremap <C-t>     <Esc>:tabnew<CR>
" Mapping to alt+arrow instead
nnoremap <A-left>   :tabprevious<CR>
nnoremap <A-right>  :tabnext<CR>
nnoremap <C-t>      :tabnew<CR>
nnoremap <C-t>      <Esc>:tabnew<enter>:FZF<CR>
inoremap <A-left>   <Esc>:tabprevious<CR>i
inoremap <A-right>  <Esc>:tabnext<CR>i
inoremap <C-t>      <Esc>:tabnew<enter>:FZF<CR>


" ---------------
" Color Scheme
" ---------------
" http://agonzalezro.github.io/best-vim-colors-ever.html
" colorscheme desertEx
colorscheme jellybeans
" colorscheme wombat256mod
" colorscheme codedark
set t_Co=256
set t_ut=
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
" try
"     let g:codedark_conservative = 0
"     colorscheme codedark
" catch
"     set background=dark
" endtry
syntax on



" Config
set number                      "Turn on line-numbers
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set undolevels=700              "Store lots of undo's in history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set autoread                    "Reload files changed outside vim
set nowrap                      "Don't wrap lines
set linebreak                   "Wrap lines at convenient points

" Scrolling
set scrolloff=4         "Start scrolling when we're 4 lines away from margins
set sidescrolloff=15
set sidescroll=1

" Turn off swap files
set noswapfile
set nobackup
set nowb

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Say no to code folding...
" autocmd BufRead,BufEnter *.css setlocal foldmethod=marker
" set nofoldenable
" SimpylFold
"autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
"autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
let g:SimpylFold_docstring_preview = 1

"
"" Set folding shortcuts
nnoremap <space> za
vnoremap <space> zf
"

" Disable K looking stuff up
map K <Nop>

" (Hopefully) removes the delay when hitting esc in insert mode
"set noesckeys
set ttimeout
set ttimeoutlen=1

" Yanks go on clipboard instead.
set clipboard+=unnamed

" Show matching brackets.
set showmatch

" Search
set incsearch        "Find the next match as we type the search
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
set ignorecase
set smartcase


" Persistent Undo
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif



nmap ^[{ :tabnext<cr>
imap ^[{ <ESC>:tabnext<cr>
nmap ^[} :tabprevious<cr>
imap ^[} <ESC>:tabprevious<cr>

" Indentation
set pastetoggle=<F2> " Press F2 in insert mode for better paste
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" do not convert tab to space for these filetypes
" do not change it for makefiles
autocmd FileType make setlocal noexpandtab
autocmd FileType cpp setlocal noexpandtab

" easier moving of code blocks
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

" Undo/redo
:map <C-z> <Esc>u<CR>
" ctrl + r redo
":map <C-Z> <Esc>:redo<CR>

" Format Help
" easier formatting of paragraphs
" with line-breaks
vmap Q gq
nmap Q gqap

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·


" Spelling
" Correct word:
"   z=
" Add word:
"   zg
nmap <silent> <leader>sp :set spell!<CR>
setlocal spell spelllang=en_us
" hi clear SpellBad
" hi SpellBad cterm=underline ctermfg=red
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Don't mark URL-like things as spelling errors
syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell

" Don't count acronyms / abbreviations as spelling errors
" (all upper-case letters, at least three characters)
" Also will not count acronym with 's' at the end a spelling error
" Also will not count numbers that are part of this
" Recognizes the following as correct:
syn match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell

" No spelling as default
set nospell

" copy'n'paste multisession
" Shift+y will yank the selection to work
" with multiple sessions of VIM
" https://sunaku.github.io/tmux-yank-osc52.html

function! OscCopyVbuf()
  let executeCmd='yank ~/.vbuf'
  call system(executeCmd)
  redraw!
endfunction
command! OscCopyVbuf :call OscCopyVbuf()

function! OscYank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echoerr escape
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
endfunction
noremap <silent> <Leader>y y:<C-U>call OscYank(@0)<CR>

" Copy the current visual slection to ~/.vbuf
vmap <S-y> :w! ~/.vbuf<CR>
" Copy the current line to the buffer file if no visual selection
nmap <S-y> :.w! ~/.vbuf<CR>
" Paste the contents of the buffer file
nmap <S-p> :r ~/.vbuf<CR>



"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Word wrap
" au BufRead,BufNewFile *.md,*.tex set wrap linebreak nolist textwidth=0 wrapmargin=0


" Auto Commands
if has("autocmd")
  " No more complaining about untitled documents
  autocmd FocusLost silent! :wa

  " When editing a file, always jump to the last cursor position.
  " This must be after the uncompress commands.
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line ("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif


" ----------------------------------------
" User Experience
" ----------------------------------------

" UI
if has('cmdline_info')
  set ruler                   " show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
  set showcmd                 " show partial commands in status line and
endif
set laststatus=2  " Always show the statusline
set cmdheight=1


" ----------------------------------------
" Plugs/Plugin Configuration
" ----------------------------------------


" user experience







" Numbers
" Only show relative numbers in visual mode
let g:enable_numbers = 0

" :au FocusLost * :set number
" :au FocusGained * :set relativenumber
"
" autocmd InsertEnter * :set number
" autocmd InsertLeave * :set relativenumber
" set relativenumber



" ----------------------------------------
" Functions
" ----------------------------------------

" Rename File
" Easy way of re-naming file when editing it
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

map <Leader>re :call RenameFile()<cr>



" ---------------
" vimdiff
" ---------------
if &diff
    " ignore whitespace in diffmode
    set diffopt+=iwhite
endif

" ----------------------------------------
" Filetype Settings
" ----------------------------------------
au BufRead,BufNewFile Jenkinsfile setfiletype groovy
au BufRead,BufNewFile *.src setfiletype fortran

let fortran_more_precise=1

let fortran_dialect = "f77"

let s:extfname = expand("%:e")
if s:extfname ==? "f90"
    let fortran_free_source=1
    unlet! fortran_fixed_source
else
    let fortran_fixed_source=1
    unlet! fortran_free_source
endif

" Jenkinsfile is groovy syntax

" :w!!
" write the file when you accidentally opened it without the right (root) privileges
cmap w!! w !sudo tee % > /dev/null


" Ignore whitespace diff mode
if &diff
    " diff mode
    set diffopt+=iwhite
endif


" mouse
" TODO edit
set mouse=a " mouse in all modes
"set mouse=i " mouse insert mode only
set ttymouse=xterm


" backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set nobackup nowritebackup

