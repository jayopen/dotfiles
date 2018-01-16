" VIMRC
" ----------------------------------
" HEADER (commands that should come first)
" ----------------------------------
set nocompatible
call pathogen#infect()
source ~/.vim/regexlist.vim

" ----------------------------------
" Basic Vim Settings
" ----------------------------------
set nocompatible     "Who cares about legacy support
syntax on            "Colors are good
set showmode         "Show the current mode below statusline
set nowrap           "Don't wrap lines
set scrolloff=2      "Minimum lines to keep above and below cursor
set hlsearch         "Highlight search results
set incsearch        "Show search results as you type
set hidden           "Sets buffers as hidden
set mouse+=a         "Required for some basic mouse usage
set textwidth=0      "Set the default textwidth in columns
set ttyfast          "Speed up vim?

" Tabs
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Line number
set norelativenumber        "Relative number is kinda annoying
set number                  "Default to relativenumber
set colorcolumn=80,100      "Highlight columns 80 (python), 100 (go)

" Statusline
set laststatus=2
highlight clear SignColumn

" ----------------------------------
" Markdown File Format Handling
" ----------------------------------
au BufNewFile,BufRead,BufReadPost *.md set filetype=markdown
au BufNewFile,BufRead,BufReadPost *.md set shiftwidth=4
au BufNewFile,BufRead,BufReadPost *.md set tabstop=4
au BufNewFile,BufRead,BufReadPost *.md set foldlevel=255
au BufNewFile *.md r ~/.vim/skeleton.md
au BufNewFile,BufRead,BufReadPost *.go set tabstop=4

" ----------------------------------
" Solarized Colorscheme
" ----------------------------------
colorscheme solarized
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="low"
let g:solarized_contrast="high"
let g:solarized_visibility="high"
set background=dark

" ----------------------------------
" Airline Configuration
" ----------------------------------

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatted = 'default'
let g:airline#extensions#tabline#fnamemod = ':t'

" ----------------------------------
" GitGutter Configuration
" ----------------------------------
let g:gitgutter_sign_column_always = 1  "Always show gitgutter

" ----------------------------------
" NERDTree Settings
" ----------------------------------
let g:NERDTreeHijackNetrw = 0
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" ----------------------------------
" Leader Mappings
" ----------------------------------
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>eb :vsplit ~/.bashrc<cr>
nnoremap <leader>f :GoFmt<cr>:GoImports<cr>:w<cr>
nnoremap <silent> <leader>, :tabprevious<CR>
nnoremap <silent> <leader>. :tabnext<CR>
nnoremap <silent> <leader>n :tabnew<CR>
nnoremap <leader>[ :NERDTreeToggle<cr>
nnoremap <leader>\ :NERDTreeToggle<cr>
nnoremap <leader>] :TlistToggle<cr>

" ----------------------------------
" Keyboard Shortcuts
" ----------------------------------
" Remove trailing whitepsace
nnoremap <F12> :%s/\s\+$//e<CR>

" Remove leading whitespace
nnoremap <F11> :%s/^\s\+<CR>

" F1 shouldn't load help
map <F1> <Esc>

" F3 foldlevel = 255
:nmap <F3> :set foldlevel=255<CR>
:nmap <F4> :set foldlevel=0<CR>

" Insert Date
nnoremap <F9> "=strftime("%Y%m%d")<CR>pA<esc>
nnoremap <F8> "=strftime("%H:%M")<CR>pA<esc>

" Handle :Q!
command -bang Q quit<bang>

" Shortcut for save
nmap WW :w<CR>

" Paste Mode Toggle
nnoremap <F2> :set invpaste paste?<CR>

" CTRL-l" Paste from register *
vmap <C-l> "*p
imap <C-l> <Esc>"*p

" Toggle Highlight Search
noremap <F5> :set hlsearch! hlsearch?<CR>

" Duplicate a block of text below
" CTRL-p: Requires visual selection
" vmap <C-p> y'>pO<Esc>
" CTRL-d: Doesn't require visual selection
map <C-d> V'}y'}pO<Esc>

" CTRL-o Comma Seprate from spaces the current block
map <C-o> V'}J:.s/ /,/g<CR>

" Highlight Todo
augroup HiglightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
augroup END

" Remember where you last were in a file
:au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" Highlight Extra Whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" ----------------------------------
" Mac Keyboard Support
" ----------------------------------
nnoremap <C-P>  :tabnext<CR>
nnoremap <C-o>  :tabprev<CR>

" ----------------------------------
" Incsearch.vim Shortcuts
" ----------------------------------
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" ----------------------------------
" Disabled Configuration
" ----------------------------------

"This can have problems with other extensions like NERDTree
"set shellcmdflag=-ic "Make VIM load your .bashrc - IE learn your bash aliases with ! commands

" Make tab perform file auto completion
" inoremap <Tab> <C-X><C-F>

" Errata
"let g:NeatStatusLine_color_filetype='ctermbg=black'
"let g:NeatStatusLine_color_position='ctermbg=black'
"highlight Cursor guifg=white guibg=black
"highlight iCursor guifg=white guibg=steelblue
"set guicursor=n-v-c:block-Cursor
"set guicursor+=i:ver100-iCursor
"set guicursor+=n-v-c:blinkon0
"autocmd InsertEnter * set cul
"autocmd InsertLeave * set nocul
"let g:Powerline_symbols = 'fancy'

" CTRL-A: Select All
" (Disabled because CTRL-A is increment)
"map <C-a> ggVG

" Change linenumber based on current mode
"autocmd InsertEnter * :set number | set norelativenumber
"autocmd InsertLeave * :set relativenumber | set nonumber
"
" ----------------------------------
" FOOTER (commands that should be last)
" ----------------------------------

" This has to be the last (I guess)
filetype plugin indent on
