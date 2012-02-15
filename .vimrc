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
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
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
  "set t_Co=256          " 256 color mode
  colors ir_black
endif
set wildmenu                " turn on wild menu, try typing :h and press <Tab> 
set wildmode=list:longest,full	" command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
set showcmd                 " display incomplete commands
set ruler                   " show the cursor position all the time
set number
set winaltkeys=no
set guioptions=eGm
set guitablabel=%N:\ %t\ %M
set clipboard+=unnamed      " set clipboard for system OS 
set foldenable              "
set foldmethod=marker " indent"
"set list!
set listchars=tab:>\ ,trail:-,extends:>,precedes:<
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
"--------------------------------------------------------------------------- 
" Tip #382: Search for <cword> and replace with input() in all open buffers 
"--------------------------------------------------------------------------- 
fun! Replace() 
    let s:word = input("Replace " . expand('<cword>') . " with:") 
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge' 
    :unlet! s:word 
endfun 
"}

" encoding {
set encoding=utf-8
set termencoding=utf-8
set fileencoding=chinese
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5
"fun! ZH()
	"set encoding=chinese
	"set fileencoding=chinese
"endfun

"set langmenu=zh_CN.utf-8
set langmenu=en_gb.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages en_gb.utf-8
"}

" statusline {
set laststatus=2
set statusline=
set statusline+=%2*%-3.3n%0*\   " buffer number
set statusline+=\ %f
set statusline+=\ %{&ff=='unix'?'\\n':(&ff=='mac'?'\\r':'\\r\\n')}
set statusline+=\ %{&fenc!=''?&fenc:&enc}
set statusline+=\ %Y  "file type
set statusline+=\ %{fugitive#statusline()} "  Git Hotness
set statusline+=\ %{getcwd()}          " current dir
set statusline+=\ %=%-10.(%l,%c%V%)\ %p%%  " Right aligned file nav info
set statusline+=\ %#warningmsg#
set statusline+=\ %{SyntasticStatuslineFlag()}
set statusline+=\ %*
"set statusline=[%n]\ %<%.99f\ %h%w%m%r%{apsLockStatusline}%y%{fugitive#statusline}%#ErrorMsg#%{SyntasticStatuslineFlag}%*%=%-14.(%l,%c%V%)\ %P
"}
    "let g:syntastic_mode_map = { 'mode': 'active',
                               "\ 'active_filetypes': ['c', 'lua'],
                               "\ 'passive_filetypes': ['puppet'] }
" Search {
set showmatch               " 插入括号时，短暂地跳转到匹配的对应括号
set hlsearch  " highlighting searching
set incsearch " do incremental searching
set ignorecase " Set search/replace pattern to ignore case 
set smartcase " Set smartcase mode on, If there is upper case character in the search patern, the 'ignorecase' option will be override.

" C/C++ specific settings
autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"}

" Key (re)Mappings {
"The default leader is '\', but many people prefer ',' as it's in a standard
let mapleader = ','
let g:mapleader=","

"replace the current word in all opened buffers
nmap <leader>r 	:call Replace()<CR>
nmap <leader>%  :%s/<C-R><C-W>/
nmap <leader>lv :lv /<c-r>=expand("<cword>")<cr>/ %<cr>:lw<cr>  "list search
" Search the current file for what's currently in the search register and display matches
nmap <leader>gs :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>
" Search the current file for the word under the cursor and display matches
nmap <leader>gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>
" Search the current file for the WORD under the cursor and display matches
nmap <leader>gW :vimgrep /<C-r><C-w>/ **/*.*<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>
" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'p <S-H> gT
nmap <leader>u 	:MRU<CR>
nmap <leader>nt :NERDTreeFind<CR>
nmap <leader>e 	:NERDTreeToggle<CR>:NERDTreeMirror<CR>
nmap <leader>l 	:TagbarToggle<CR>
nmap <leader>t 	:CommandT<CR>
nmap <leader>b 	:CommandTBuffer<CR>
map <C-s> 	:w!<CR> 

" --- Ctags
" This will look in the current directory for 'tags', and work up the tree towards root until one is found. 
set tags=./tags,../../tags,$HOME/vimtags
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
inoremap <M-o>      <C-O>o
inoremap <M-O>      <C-O>O
inoremap <M-i>      <Left>
inoremap <M-I>      <C-O>^
inoremap <M-A>      <C-O>$
inoremap <CR>       <C-G>u<CR>

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
" cnoremap <C-A>      <Home>
"cnoremap <C-B>      <Left>
"cnoremap <C-E>      <End>
"cnoremap <C-F>      <Right>
"cnoremap <C-N>      <End>
"cnoremap <C-P>      <Up>
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
"let g:lua_complete_omni = 1

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.git', '\.hg', '\.svn', '\.dsp', '\.opt', '\.plg', '*.exe', '*.dll']

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

let g:neocomplcache_enable_at_startup = 1
"let g:NeoComplCache_DisableAutoComplete = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" <TAB>: completion.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
"}
