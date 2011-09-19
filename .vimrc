" jimluo's vimrc
" luo jin <luojinlj@gmail.com>
" fork me https://github.com/jimluo/vimrc
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

" For pathogen.vim: auto load all plugins in .vim/bundle
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" General {
set nocompatible            " close vi mode
syntax on                   " auto syntax highlighting
filetype on   
filetype plugin indent on   " find type in .vim/ftplugin/
"set helplang=cn             " maybe en
set autowrite
" }

" Vim UI {
if has("gui_running")	" GUI color and font settings
  set guifont=Monaco:h10
  "set background=dark 
  set cursorline        " highlight current line
  colors ir_black
else " terminal color settings
  "set t_Co=256          " 256 color mode
  colors ir_black
endif
set wildmenu                " turn on wild menu, try typing :h and press <Tab> 
set wildmode=list:longest,full	" command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
set showcmd                 " display incomplete commands
"set ruler                   " show the cursor position all the time
set winaltkeys=no
set guioptions=eGm
set guitablabel=%N:\ %t\ %M
set clipboard+=unnamed      " set clipboard for system OS 
set foldenable              "
set foldmethod=indent
set list
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<
" }

" Formatting {
"set number                  " Show LineNumber
set autoindent 
set smartindent 
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set expandtab " Set expandtab on, the tab will be change to space automaticaly
set smarttab
"set tabstop=4 " Set tabstop to 4 characters
"set softtabstop=4
"set shiftwidth=4
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
"
" make CSS omnicompletion work for SASS and SCSS
autocmd BufNewFile,BufRead *.scss             set ft=scss.css
autocmd BufNewFile,BufRead *.sass             set ft=sass.css
"}

" encoding {
set encoding=utf-8
set termencoding=utf-8
set fileencoding=chinese
set fileencodings=ucs-bom,utf-8,cp936,chinese
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
"set statusline+=\ %{fugitive#statusline()} "  Git Hotness
set statusline+=\ %{getcwd()}          " current dir
set statusline+=\ %=%-10.(%l,%c%V%)\ %p%%  " Right aligned file nav info
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
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"}

" Key (re)Mappings {
"The default leader is '\', but many people prefer ',' as it's in a standard
let mapleader = ','
let g:mapleader=","

"replace the current word in all opened buffers
map <leader>r :call Replace()<CR>
nmap <leader>%  :%s/<C-R><C-W>/
nmap <leader>lv :lv /<c-r>=expand("<cword>")<cr>/ %<cr>:lw<cr>  "list search
nmap <leader>nt :NERDTreeFind<CR>
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <C-l> :TagbarOpen<CR>
map <C-t> :CommandT<CR>
map <C-b> :CommandTBuffer<CR>
map <C-s> :w!<CR> 

let g:shell_mappings_enabled = 0
map <C-F11> :Fullscreen<CR>
map <C-F12>op :Open<CR>

" --- Ctags
" This will look in the current directory for 'tags', and work up the tree towards root until one is found. 
set tags=./tags;/,$HOME/vimtags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR> " C-\ - Open the definition in a new tab
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>      " A-] - Open the definition in a vertical split
map <C-F10> <Esc>:vsp<CR>:VTree<CR>
"
" open the error console
map <leader>cc :botright cope<CR> 
" move to next error
map <leader>] :cn<CR>
" move to the prev error
map <leader>[ :cp<CR>

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>
map <C-K> <C-W>k<C-W>
map <C-L> <C-W>l<C-W>
map <C-H> <C-W>h<C-W>

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" The following two lines conflict with moving to top and bottom of the
map <S-H> gT
map <S-L> gt

" new tab
map <C-t><C-t> :tabnew<CR>
" close tab
map <C-t><C-w> :tabclose<CR> 

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

""" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>

"clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

" ,p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv 

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
" Ctrl-[ jump out of the tag stack (undo Ctrl-])
map <C-[> <ESC>:po<CR>
"}

" omni completion. plugin options {
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType html,markdown set noexpandtab
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType lua setlocal ts=2 sts=2 sw=2 expandtab 
let g:lua_complete_omni = 1

"autocmd FileType objc set makeprg=rake
" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
              \	if &omnifunc == "" |
              \		setlocal omnifunc=syntaxcomplete#Complete |
              \	endif
endif


let b:match_ignorecase = 1
au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim

" --- Command-T
let g:CommandTMaxHeight = 15

" --- SuperTab
let g:SuperTabDefaultCompletionType = "context"

" --- EasyMotion
"let g:EasyMotion_leader_key = '<Leader>m' " default is <Leader>w
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

" --- TagBar
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1


let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.dsp', '\.opt', '\.plg']
"}
