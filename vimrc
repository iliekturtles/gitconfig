" XDG setup.
if empty($XDG_CONFIG_HOME)
    let $XDG_CONFIG_HOME=expand('$HOME/.config')
endif
if empty($XDG_CACHE_HOME)
    let $XDG_CACHE_HOME=expand('$HOME/.cache')
endif

set backupdir=$XDG_CACHE_HOME/vim/backup
set directory=$XDG_CACHE_HOME/vim/swap//
set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/bundle/Vundle.vim
set undodir=$XDG_CACHE_HOME/vim/undo
set viminfo='1000,s100,h,n$XDG_CACHE_HOME/vim/viminfo

" Vundle
filetype off

call vundle#begin('$XDG_CONFIG_HOME/vim/bundle')

Plugin 'gmarik/Vundle.vim'
Plugin 'iliekturtles/vim-unicon'
if has('python')
    Plugin 'Valloric/YouCompleteMe'
else
    Plugin 'ervandew/supertab'
    if !empty($RACER_PATH)
        Plugin 'racer-rust/vim-racer'
    endif
end
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-speeddating'
Plugin 'iliekturtles/vim-unimpaired'
Plugin 'itchyny/lightline.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'vim-scripts/matchit.zip'
Plugin 'w0rp/ale'
Plugin 'sheerun/vim-polyglot'
Plugin 'OrangeT/vim-csharp'

call vundle#end()
filetype plugin indent on

" Defaults.
set autoread
set autowrite
set backspace=indent,eol,start
set confirm
set cursorline
set encoding=utf-8
set expandtab
set fo+=j               " Remove comment leader when joining lines.
set gdefault
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
if has('gui')
    set guioptions-=e
    set guioptions-=tT
endif
set hlsearch incsearch ignorecase smartcase
set hidden
set keywordprg=:help
set laststatus=2
set lazyredraw
set list listchars=tab:→ ,space:·,trail:·,nbsp:·
if has('mouse')
    set mouse=a
endif
set nojoinspaces
set noshowmode
set nowrap
set nrformats-=octal
set pastetoggle=<F2>
set scrolloff=5
set shiftwidth=4
set showcmd
set showmatch
set sidescroll=1
set sidescrolloff=10
set signcolumn=yes
set smarttab
set switchbuf=useopen,usetab
set tabstop=4
set tildeop
set updatetime=1000
set vb
set wildmenu
set wildmode=list:longest

syntax on

let mapleader=','

" Map ,, to ,'s original functionality.
nnoremap <leader>, ,

" Use very magic searching.
nnoremap / /\v
vnoremap / /\v

" Map e to toggle NERDTree.
nnoremap <leader>e :NERDTreeToggle<cr>

" Map bl to show the buffer list and prompt for selection.
nnoremap <leader>bl :ls<cr>:b<space>

"Map bw to wipe the current buffer and switch to the alternate buffer.
nnoremap <leader>bw :b#\|bw#<cr>

"Map bv to open the alternate buffer in a new split.
nnoremap <leader>bv :b#\|vsp#<cr>

" Map space to stop search highlighting.
nnoremap <leader><space> :noh<cr>

" Map visual mode F2 to run the selection as an ex command.
vnoremap <f2> :<c-u>exe join(getline("'<","'>"),'<bar>')<cr>

" Map gg to toggle GitGutter.
nnoremap <leader>gg :GitGutterToggle<cr>

" Map h to toggle hex mode.
nnoremap <leader>h :Hexmode<cr>

" Map Y yank to the end of the line.
noremap Y y$

" Replace and delete without yanking unless <leader> is used.
if has('xterm_clipboard')
    set clipboard^=unnamed,unnamedplus
    let g:register = '+'
elseif has('clipboard')
    set clipboard^=unnamed
    let g:register = '*'
else
    let g:register = '"'
endif

function! s:reg()
    return v:register ==# g:register ? '"_' : ''
endfunction

vnoremap <expr> p '"_d"' . v:register . 'P'
vnoremap <leader>p p

nnoremap <expr> c <sid>reg() . 'c'
nnoremap <leader>c c
vnoremap <expr> c <sid>reg() . 'c'
vnoremap <leader>c c
nnoremap <expr> C <sid>reg() . 'C'
nnoremap <leader>C C
vnoremap <expr> C <sid>reg() . 'C'
vnoremap <leader>C C
nnoremap <expr> d <sid>reg() . 'd'
nnoremap <leader>d d
vnoremap <expr> d <sid>reg() . 'd'
vnoremap <leader>d d
nnoremap <expr> D <sid>reg() . 'D'
nnoremap <leader>D D
vnoremap <expr> D <sid>reg() . 'D'
vnoremap <leader>D D
nnoremap <expr> s <sid>reg() . 's'
nnoremap <leader>s s
vnoremap <expr> s <sid>reg() . 's'
vnoremap <leader>s s
nnoremap <expr> S <sid>reg() . 'S'
nnoremap <leader>S S
vnoremap <expr> S <sid>reg() . 'S'
vnoremap <leader>S S
nnoremap <expr> x <sid>reg() . 'x'
nnoremap <leader>x x
vnoremap <expr> x <sid>reg() . 'x'
vnoremap <leader>x x
nnoremap <expr> X <sid>reg() . 'X'
nnoremap <leader>X X
vnoremap <expr> X <sid>reg() . 'X'
vnoremap <leader>X X

" Map f to copy the full file path.
nnoremap <expr> <leader>f ':let @' . g:register . ' = expand("%:p")<CR>'

" Map j and k to non-linewise movements.
nmap j gj
nmap k gk

" Map C-<direction> to move between splits and tmux panes.
function! TmuxMove(direction)
    let wnr = winnr()
    silent! execute 'wincmd ' . a:direction
    " If the winnr is still the same after we moved, it is the last pane
    if wnr == winnr()
        call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
    end
endfunction

nnoremap <silent> <c-h> :call TmuxMove('h')<cr>
nnoremap <silent> <c-j> :call TmuxMove('j')<cr>
nnoremap <silent> <c-k> :call TmuxMove('k')<cr>
nnoremap <silent> <c-l> :call TmuxMove('l')<cr>

" Map C-scroll weel to scroll horizontally.
noremap <C-ScrolLWheelDown> 4zl
noremap <C-ScrolLWheelUp> 4zh
noremap! <C-ScrolLWheelDown> <C-o>4zl
noremap! <C-ScrolLWheelUp> <C-o>4zh

" Hexmode, http://vim.wikia.com/wiki/Improved_hex_editing
command -bar Hexmode call ToggleHex()

function ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1

    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        silent :e " this will reload the file without trickeries
        "           (DOS line endings will be shown entirely )
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif

    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction

" Colors.
let g:lightline={
\   'active': {
\       'right': [
\           ['lineinfo'],
\           ['percent'],
\           ['fileformat', 'fileencoding', 'filetype'],
\       ]
\   }
\}
set t_Co=256
" set termguicolors
set t_ut=
set background=dark
colorscheme unicon

" Vertical edge.
let cc81=join(range(81, 255), ',')
let cc101=join(range(101, 255), ',')
let &colorcolumn=cc101

" Autocommands
augroup vimrc
    au!

    au BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo | nnoremap <C-Q> :make build<CR>
    au BufRead,BufNewFile *.sql set commentstring=--\ %s

    au FileType gitcommit,markdown,text setlocal spell
    au FileType gitcommit let &l:colorcolumn=cc81 | setlocal tabstop=4
    au FileType qf setlocal scrolloff=0
    au FileType qf wincmd J

    au QuickFixCmdPost [^l]* nested cwindow
    au QuickFixCmdPost l* nested lwindow
augroup end

" CtrlP
if executable('rg')
    let g:ctrlp_user_command = 'rg --files --color never %s'
    let g:ctrlp_use_caching = 0
endif

" Git-gutter signs (en-space + right half block).
let g:gitgutter_sign_added = ' ▐'
let g:gitgutter_sign_modified = ' ▐'
let g:gitgutter_sign_removed = ' ▐'
let g:gitgutter_sign_removed_first_line = ' ▐'
let g:gitgutter_sign_modified_removed = ' ▐'

" ALE
let g:ale_linters = {'rust': ['rls']}
let g:ale_fixers = {'rust': ['rustfmt']}
" let g:ale_completion_enabled = 1
let g:ale_open_list = 1
let g:ale_sign_error = '⮿'
let g:ale_sign_info = '🛈'
let g:ale_sign_warning = '🔺'

" GUI settings.
if has('gui')
    set guifont=Consolas:h11

    au GUIEnter * simalt ~x
endif
