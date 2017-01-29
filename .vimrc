"     ___       ___       ___       ___       ___   
"    /\__\     /\  \     /\__\     /\  \     /\  \  
"   /:/ _/_   _\:\  \   /::L_L_   /::\  \   /::\  \ 
"  |::L/\__\ /\/::\__\ /:/L:\__\ /::\:\__\ /:/\:\__\
"  |::::/  / \::/\/__/ \/_/:/  / \;:::/  / \:\ \/__/
"   L;;/__/   \:\__\     /:/  /   |:\/__/   \:\__\  
"              \/__/     \/__/     \|__|     \/__/  

let mapleader="\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>s :%s/
nmap <silent> <Space><Space> :nohlsearch<CR>
nnoremap ; :
nnoremap : ;
set incsearch
set hlsearch
set laststatus=2
set ignorecase
set smartcase
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set shiftround
set infercase
set virtualedit=all
set hidden
set switchbuf=useopen
set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
set backspace=indent,eol,start

if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus,unnamed 
else
    set clipboard& clipboard+=unnamed
endif

syntax on
syntax enable
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

set wrap
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set textwidth=0
set colorcolumn=80

set number
set cursorline
set ruler
set t_Co=256
set wildmenu

set t_vb=
set novisualbell

nnoremap O :<C-u>call append(expand('.'), '')<Cr>j
inoremap <silent> jj <ESC>
nnoremap <Leader>a :a!<CR>

vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap j gj
nnoremap k gk
vnoremap v $h

nnoremap <Tab> %
vnoremap <Tab> %

nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

cmap w!! w !sudo tee > /dev/null %

function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
let s:noplugin=0
let s:bundle_root=expand('~/.vim/bundle')
let s:neobundle_root=s:bundle_root . '/neobundle.vim'
if !isdirectory(s:neobundle_root) || v:version < 702
    let s:noplugin=1
else
    if has('vim_starting')
        execute "set runtimepath+=" . s:neobundle_root
    endif

    call neobundle#begin(s:bundle_root)
    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle "Shougo/vimproc", {
        \ "build": {
        \   "windows"   : "make -f make_mingw32.mak",
        \   "cygwin"    : "make -f make_cygwin.mak",
        \   "mac"       : "make -f make_mac.mak",
        \   "unix"      : "make -f make_unix.mak",
        \ }}
    NeoBundle 'Shougo/neocomplete'
    NeoBundleLazy "davidhalter/jedi-vim", {
          \ "autoload": {
          \   "filetypes": ["python", "python3", "djangohtml"]
          \ }}
    NeoBundleLazy 'Shougo/neosnippet.vim', {
        \ "autoload": {"insert": 1}}
    NeoBundleLazy 'sjl/gundo.vim', {
        \ "autoload": {"commands": ["GundoToggle"]}}
    NeoBundleLazy 'vim-scripts/TaskList.vim', {
        \ "autoload": {"mappings": ['<Plug>TaskList']}}
    NeoBundleLazy 'mattn/zencoding-vim', {
        \ "autoload": {"filetypes": ['html']}}
    NeoBundle "thinca/vim-template"

    NeoBundleLazy "Shougo/unite.vim", {
          \ "autoload": {
          \   "commands": ["Unite", "UniteWithBufferDir"]
          \ }}
    NeoBundleLazy 'h1mesuke/unite-outline', {
          \ "autoload": {
          \   "unite_sources": ["outline"],
          \ }}
    NeoBundleLazy "Shougo/vimfiler", {
      \ "depends": ["Shougo/unite.vim"],
      \ "autoload": {
      \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
      \   "mappings": ['<Plug>(vimfiler_switch)'],
      \   "explorer": 1,
      \ }}
    NeoBundleLazy 'majutsushi/tagbar', {
          \ "autload": {
          \   "commands": ["TagbarToggle"],
          \ },
          \ "build": {
          \   "mac": "brew install ctags",
          \ }}
    NeoBundle "scrooloose/syntastic"
    NeoBundleLazy "lambdalisue/vim-django-support", {
          \ "autoload": {
          \   "filetypes": ["python", "python3", "djangohtml"]
          \ }}
    NeoBundleLazy "jmcantrell/vim-virtualenv", {
          \ "autoload": {
          \   "filetypes": ["python", "python3", "djangohtml"]
          \ }}

    NeoBundle 'tpope/vim-surround'
    NeoBundle 'vim-scripts/Align'
    NeoBundle 'vim-scripts/YankRing.vim'

    NeoBundle 'nanotech/jellybeans.vim'
    NeoBundle 'tomasr/molokai'
    NeoBundle 'w0ng/vim-hybrid'

    NeoBundle "itchyny/lightline.vim"
    NeoBundle "Yggdroot/indentLine"
    NeoBundle 'cohama/lexima.vim'

    call neobundle#end()

    " neocomplete
    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      " return neocomplete#close_popup() . "\<CR>"
      " For no inserting <CR> key.
      return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()

    autocmd FileType python setlocal omnifunc=jedi#completions
    if !exists('g:neocomplete#force_omni_input_patterns')
         let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0
    let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
    nnoremap <Leader>g :GundoToggle<CR>
    autocmd User plugin-template-loaded call s:template_keywords()
    function! s:template_keywords()
        silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
        silent! %s/<+FILENAME+>/\=expand('%:r')/g
    endfunction
    autocmd User plugin-template-loaded
        \   if search('<+CURSOR+>')
        \ |   silent! execute 'normal! "_da>'
        \ | endif

    " unite.vim
    nnoremap [unite] <Nop>
    nmap U [unite]
    nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
    nnoremap <silent> [unite]r :<C-u>Unite register<CR>
    nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
    nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
    nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
    nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
    nnoremap <silent> [unite]w :<C-u>Unite window<CR>
    let s:hooks=neobundle#get_hooks("unite.vim")
    function! s:hooks.on_source(bundle)
      " start unite in insert mode
      let g:unite_enable_start_insert=1
      " use vimfiler to open directory
      call unite#custom_default_action("source/bookmark/directory", "vimfiler")
      call unite#custom_default_action("directory", "vimfiler")
      call unite#custom_default_action("directory_mru", "vimfiler")
      autocmd  FileType unite call s:unite_settings()
      function! s:unite_settings()
        imap <buffer> <Esc><Esc> <Plug>(unite_exit)
        nmap <buffer> <Esc> <Plug>(unite_exit)
        nmap <buffer> <C-n> <Plug>(unite_select_next_line)
        nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
      endfunction
    endfunction

    " vimfiler
    "<Space>fi to run vimfiler
    nnoremap <Leader>fi :VimFilerExplorer<CR>
    " close vimfiler automatically when there are only vimfiler open
    autocmd BufEnter * if (winnr('$')==1 && &filetype ==# 'vimfiler') | q | endif
    let s:hooks=neobundle#get_hooks("vimfiler")
    function! s:hooks.on_source(bundle)
      let g:vimfiler_as_default_explorer=1 
      let g:vimfiler_enable_auto_cd=1

      " vimfiler specific key mappings
      autocmd FileType vimfiler call s:vimfiler_settings()
      function! s:vimfiler_settings()
        " ^^ to go up
        nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
        " use R to refresh
        nmap <buffer> R <Plug>(vimfiler_redraw_screen)
        " overwrite C-l
        nmap <buffer> <C-l> <C-w>l
      endfunction
    endfunction

    if !exists('g:neocomplete#force_omni_input_patterns')
            let g:neocomplete#force_omni_input_patterns = {}
    endif

    let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

    nmap <Leader>t :TagbarToggle<CR>

    let g:syntastic_python_checkers=['pyflakes', 'pep8']
    " original http://stackoverflow.com/questions/12374200/using-uncrustify-with-vim/15513829#15513829
    function! Preserve(command)
        " Save the last search.
        let search=@/
        " Save the current cursor position.
        let cursor_position=getpos('.')
        " Save the current window position.
        normal! H
        let window_position=getpos('.')
        call setpos('.', cursor_position)
        " Execute the command.
        execute a:command
        " Restore the last search.
        let @/=search
        " Restore the previous window position.
        call setpos('.', window_position)
        normal! zt
        " Restore the previous cursor position.
        call setpos('.', cursor_position)
    endfunction

    function! Autopep8()
        call Preserve(':silent %!autopep8 --ignore=E501 -')
    endfunction

    " Shift + F autopep8
    autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>

    " Linux Users
    " Add these colours to ~/.Xresources:
    " http://gist.github.com/3278077
    colorscheme hybrid
    highlight LineNr ctermfg=3 ctermbg=none 
    highlight Normal ctermbg=none

    " lightline
    let g:lightline={
            \ 'colorscheme': 'jellybeans',
            \ 'mode_map': {'c': 'NORMAL'},
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
            \ },
            \ 'component_function': {
            \   'modified': 'MyModified',
            \   'readonly': 'MyReadonly',
            \   'fugitive': 'MyFugitive',
            \   'filename': 'MyFilename',
            \   'fileformat': 'MyFileformat',
            \   'filetype': 'MyFiletype',
            \   'fileencoding': 'MyFileencoding',
            \   'mode': 'MyMode'
            \ }
            \ }

    function! MyModified()
      return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! MyReadonly()
      return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
    endfunction

    function! MyFilename()
      return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
            \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
            \  &ft == 'unite' ? unite#get_status_string() :
            \  &ft == 'vimshell' ? vimshell#get_status_string() :
            \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
            \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction

    function! MyFugitive()
      try
        if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
          return fugitive#head()
        endif
      catch
      endtry
      return ''
    endfunction

    function! MyFileformat()
      return winwidth(0) > 70 ? &fileformat : ''
    endfunction

    function! MyFiletype()
      return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
    endfunction

    function! MyFileencoding()
      return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction

    function! MyMode()
      return winwidth(0) > 60 ? lightline#mode() : ''
    endfunction

    let g:indentLine_color_term=111
    let g:indentLine_color_gui='#708090'

    NeoBundleCheck
endif
filetype plugin indent on
