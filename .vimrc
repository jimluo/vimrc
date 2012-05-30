" jimluo's vimrc
" vim:set ft=vim et tw=78 sw=2:

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" General {
set nocompatible            " close vi mode
syntax on                   " auto syntax highlighting
filetype on   
filetype plugin indent on   " find type in .vim/ftplugin/
"set helplang=cn             " maybe en
set autowrite
set wildignore=*.swp,*.bak,*.pyc,*.class,*.tmp,*.a,*.o,*.obj,*.so.*.zip,*.exe,*.dll,.git,.hg,.svn
set visualbell
set noerrorbells
set nobackup
set noswapfile
" }

" Vim UI {
if has("gui_running")	" GUI color and font settings
  set guifont=Monaco:h10
  "set background=dark 
  set cursorline        " highlight current line
  colors molokai
else " terminal color settings
  set t_Co=256          " 256 color mode
  colors ir_black
endif
set wildmenu                " turn on wild menu, try typing :h and press <Tab> 
set wildmode=list:longest,full	" command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
set showcmd                 " display incomplete commands
set ruler                   " show the cursor position all the time
set laststatus=2   " Always show the statusline
" set number
set winaltkeys=no
set guioptions=
set clipboard+=unnamed      " set clipboard for system OS 
"set list!
set listchars=tab:>\ ,trail:-,extends:>,precedes:<
set cscopetag
" }

" Formatting {
"set number                  " Show LineNumber
set hidden
"set autoindent
set copyindent
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set smarttab
"set fileformats=unix,dos,mac
set grepprg=grep\ -rnH\ --exclude='.*.swp'\ --exclude='*~'\ --exclude=tags
" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,python,lua,wlua,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
"}


" encoding {
set encoding=utf-8
set termencoding=utf-8
set fileencoding=chinese
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5
"set langmenu=zh_CN.utf-8
set langmenu=en_gb.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages en_gb.utf-8
"}

" Search {
set showmatch               " 插入括号时，短暂地跳转到匹配的对应括号
set hlsearch  " highlighting searching
set incsearch " do incremental searching
set ignorecase " Set search/replace pattern to ignore case 
set smartcase " Set smartcase mode on, If there is upper case character in the search patern, the 'ignorecase' option will be override.

" C/C++ specific settings
autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

"Restore cursor to file position in previous editing session
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"}

" Key (re)Mappings {
"The default leader is '\', but many people prefer ',' as it's in a standard
let mapleader = ','
let g:mapleader=","

"replace the current word in all opened buffers
nmap <leader>%  :%s/<C-R><C-W>/
" Search the current file for the word under the cursor and display matches
nmap <leader>gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>
" Search the current file for the WORD under the cursor and display matches
nmap <leader>gW :vimgrep /<C-r><C-w>/ **/*.cpp *.c *.h *.java *.js *.py *.lua<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>
" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'p <S-H> gT
nmap <leader>u 	:MRU 
nmap <leader>e :NERDTreeFind<CR>
"nmap <leader>e 	:NERDTreeToggle<CR>:NERDTreeMirror<CR>
nmap <leader>l 	:TagbarOpen<CR>
map <C-s> 	:w!<CR> 

" --- Ctags
" This will look in the current directory for 'tags', and work up the tree towards root until one is found. 
set tags=./tags,../tags,../../tags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR> " C-\ - Open the definition in a new tab
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>      " A-] - Open the definition in a vertical split
map <C-F10> <Esc>:vsp<CR>:VTree<CR>

nmap <C-F12> :!start explorer /select,%:p <CR>
imap <C-F12> <Esc><C-F12>

nmap <C-F11> :!start cmd /select,%:p <CR>
imap <C-F11> <Esc><C-F11> <CR>
" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
" Ctrl-[ jump out of the tag stack (undo Ctrl-])
map <C-[> <ESC>:po<CR>
"

" Emacs style mappings
inoremap     <C-X><C-@> <C-A>
inoremap          <C-A> <C-O>^
cnoremap          <C-A> <Home>
inoremap          <C-E> <End>
cnoremap     <C-X><C-A> <C-A>
map!              <M-b> <S-Left>
map!              <M-f> <S-Right>
noremap!          <M-d> <C-O>dw
noremap!          <M-h> <C-W>
noremap!          <M-a> <C-O>(
noremap!          <M-e> <C-O>)
noremap!          <M-{> <C-O>{
noremap!          <M-}> <C-O>}
inoremap          <M-o> <C-O>o
inoremap          <M-O> <C-O>O
"The following two lines conflict with moving to top and bottom of the
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
map <S-L> gt
"
" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap
" new tab
map <C-t><C-t> :tabnew<CR>
" close tab
map <C-t><C-w> :tabclose<CR> 

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

"clearing highlighted search
nmap <C-l> :nohlsearch<CR>

" ,p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cd. lcd %:p:h
"cmap ppw redir @* | :pwd | redir END
" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv 
"}
" Highlight word
"ai" autoindent, et:expandtab, sw:shiftwidth,tw=textwidth,ts=tabstop, cin:cindent,sts:sta:splite window for tag
autocmd FileType c,cpp,cs,java          setlocal ai et sta sw=4 sts=4 cin
autocmd FileType sh,csh,tcsh,zsh        setlocal ai et sta sw=4 sts=4
autocmd FileType tcl,perl,python        setlocal ai et sta sw=4 sts=4
autocmd FileType javascript             setlocal ai et sta sw=2 sts=2 ts=2 cin isk+=$
autocmd FileType eruby,yaml,ruby,lua    setlocal ai et sta sw=2 sts=2
autocmd FileType c,cpp,cs,java,perl,javscript,php,css let b:surround_101 = "\r\n}"
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType c,cpp setlocal omnifunc=ccomplete#Complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
"autocmd Filetype * if &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif

autocmd FileType cucumber compiler cucumber | setl makeprg=cucumber\ \"%:p\"
autocmd FileType ruby
      \ if expand('%') =~# '_test\.rb$' |
      \   compiler rubyunit | setl makeprg=testrb\ \"%:p\" |
      \ elseif expand('%') =~# '_spec\.rb$' |
      \   compiler rspec | setl makeprg=rspec\ \"%:p\" |
      \ else |
      \   compiler ruby | setl makeprg=ruby\ -wc\ \"%:p\" |
      \ endif
autocmd User Bundler
      \ if &makeprg !~# 'bundle' | setl makeprg^=bundle\ exec\  | endif

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.git', '\.hg', '\.svn', '\.dsp', '\.opt', '\.plg', '*.exe', '*.dll']

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"let g:neocomplcache_enable_quick_match = 1 "For input-saving, this variable controls whether you can  choose a candidate with a alphabet or number displayed beside a candidate after '-'.  When you input 'ho-a',  neocomplcache will select candidate 'a'.
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()


" Recommended key-mappings.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><CR>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

let Gtags_Auto_Map = 1

let MRU_Auto_Close = 1
let MRU_Max_Entries = 100

let g:Powerline_symbols = 'fancy'

" " CTRLP
let g:ctrlp_max_depth = 2
let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['tag','mixed', 'quickfix', 'dir', 'changes', 'cmdline', 'yankring', 'menu']
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_mruf_max = 100
let g:ctrlp_max_files = 100

" We don't want to use Ctrl-p as the mapping because
silent! nnoremap <unique> <silent> <Leader>t :CtrlP<CR>
silent! nnoremap <unique> <silent> <Leader>b :CtrlPBuffer<CR>
map <leader>m :CtrlPMRU<cr>
nnoremap <Leader>T :CtrlPTag<CR>  " CtrlP for tags
silent! nnoremap <unique> <silent> <Leader>f :CtrlPFiletype<CR>
" Cmd-Shift-P to clear the cache
nnoremap <silent> <D-P> :ClearCtrlPCache<cr>

let g:indent_guides_enable_on_vim_startup = 1

