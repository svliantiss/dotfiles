" .vimrc / init.vim
" The following vim/neovim configuration works for both Vim and NeoVim

" ensure vim-plug is installed and then load it
call plug#begin('~/dotfiles/neovim/plugged')
 Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
 Plug 'connorholyday/vim-snazzy'
 Plug 'tpope/vim-sensible'
 Plug '/usr/local/opt/fzf'
 Plug 'junegunn/fzf.vim'
 Plug 'scrooloose/nerdtree'
 Plug 'tpope/vim-surround'
 Plug 'vim-syntastic/syntastic'
 " General {{{
     " Abbreviations
     abbr funciton function
     abbr teh the
     abbr tempalte template
     abbr fitler filter
     abbr cosnt const
     abbr attribtue attribute
     abbr attribuet attribute
 
     set autoread " detect when a file is changed
 
     set history=1000 " change history to 1000
     set textwidth=120
 
     set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
     set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
 
     if (has('nvim'))
         " show results of substition as they're happening
         " but don't open a split
         set inccommand=nosplit
     endif
 
     set backspace=indent,eol,start " make backspace behave in a sane manner
     set clipboard=unnamed
 
     if has('mouse')
         set mouse=a
     endif
 
     " Searching
     set ignorecase " case insensitive searching
     set smartcase " case-sensitive if expresson contains a capital letter
     set hlsearch " highlight search results
     set incsearch " set incremental search, like modern browsers
     set lazyredraw " don't redraw while executing macros
 
     set magic " Set magic on, for regex
 
     " error bells
     set noerrorbells
     set visualbell
     set t_vb=
     set tm=500
 " }}}
 
 " Appearance {{{
     set number " show line numbers
     set lazyredraw "speeds up macro speed and scrolling"
     set wrap " turn on line wrapping
     set wrapmargin=10 " wrap lines when coming within n characters from side
     set linebreak " set soft wrapping
     set autoindent " automatically set indent of new line
     set ttyfast " faster redrawing
     set diffopt+=vertical
     set laststatus=2 " show the satus line all the time
     set so=7 " set 7 lines to the cursors - when moving vertical
     set wildmenu " enhanced command line completion
     set hidden " current buffer can be put into background
     set showcmd " show incomplete commands
     set noshowmode " don't show which mode disabled for PowerLine
     set wildmode=list:longest " complete files like a shell
     set shell=$SHELL
     set cmdheight=1 " command bar height
     set title " set terminal title
     set showmatch " show matching braces
     set mat=2 " how many tenths of a second to blink
 
     " Tab control
     set noexpandtab " insert tabs rather than spaces for <Tab>
     set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
     set tabstop=4 " the visible width of tabs
     set softtabstop=4 " edit as if the tabs are 4 characters wide
     set shiftwidth=4 " number of spaces to use for indent and unindent
     set shiftround " round indent to a multiple of 'shiftwidth'
 
     " code folding settings
     set foldmethod=syntax " fold based on indent
     set foldlevelstart=99
     set foldnestmax=10 " deepest fold is 10 levels
     set nofoldenable " don't fold by default
     set foldlevel=1
 
     set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
     " switch cursor to line when in insert mode, and block when not
     set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
     \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
     \,sm:block-blinkwait175-blinkoff150-blinkon175
 
     if &term =~ '256color'
         " disable background color erase
         set t_ut=
     endif
 
     " enable 24 bit color support if supported
     if (has("termguicolors"))
         if (!(has("nvim")))
             let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
             let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
         endif
         set termguicolors
     endif
 
     " highlight conflicts
     match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
 
     " LightLine {{{
         Plug 'itchyny/lightline.vim'
         Plug 'nicknisi/vim-base16-lightline'
         let g:lightline = {
         \   'colorscheme': 'base16',
         \   'active': {
         \       'left': [ [ 'mode', 'paste' ],
         \               [ 'gitbranch' ],
         \               [ 'readonly', 'filetype', 'filename' ]],
         \       'right': [ [ 'percent' ], [ 'lineinfo' ],
         \               [ 'fileformat', 'fileencoding' ],
         \               [ 'linter_errors', 'linter_warnings' ]]
         \   },
         \   'component_expand': {
         \       'linter': 'LightlineLinter',
         \       'linter_warnings': 'LightlineLinterWarnings',
         \       'linter_errors': 'LightlineLinterErrors',
         \       'linter_ok': 'LightlineLinterOk'
         \   },
         \   'component_type': {
         \       'readonly': 'error',
         \       'linter_warnings': 'warning',
         \       'linter_errors': 'error'
         \   },
         \   'component_function': {
         \       'fileencoding': 'LightlineFileEncoding',
         \       'filename': 'LightlineFileName',
         \       'fileformat': 'LightlineFileFormat',
         \       'filetype': 'LightlineFileType',
         \       'gitbranch': 'LightlineGitBranch'
         \   },
         \   'tabline': {
         \       'left': [ [ 'tabs' ] ],
         \       'right': [ [ 'close' ] ]
         \   },
         \   'tab': {
         \       'active': [ 'filename', 'modified' ],
         \       'inactive': [ 'filename', 'modified' ],
         \   },
         \   'separator': { 'left': '', 'right': '' },
         \   'subseparator': { 'left': '', 'right': '' }
         \ }
 
     map <silent> <C-h> :call functions#WinMove('h')<cr>
     map <silent> <C-j> :call functions#WinMove('j')<cr>
     map <silent> <C-k> :call functions#WinMove('k')<cr>
     map <silent> <C-l> :call functions#WinMove('l')<cr>
 
     nnoremap <silent> <leader>z :call functions#zoom()<cr>
 
     map <leader>wc :wincmd q<cr>
 
     inoremap <tab> <c-r>=functions#Smart_TabComplete()<CR>
 
     " NERDTree {{{
         Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
         Plug 'Xuyuanp/nerdtree-git-plugin'
         Plug 'ryanoasis/vim-devicons'
         Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
         let g:WebDevIconsOS = 'Darwin'
         let g:WebDevIconsUnicodeDecorateFolderNodes = 1
         let g:DevIconsEnableFoldersOpenClose = 1
         let g:DevIconsEnableFolderExtensionPatternMatching = 1
         let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
         let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible
         let NERDTreeNodeDelimiter = "\u263a" " smiley face
 
         augroup nerdtree
             autocmd!
             autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
             autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
         augroup END
 
         " Toggle NERDTree
         function! ToggleNerdTree()
             if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
                 :NERDTreeFind
             else
                 :NERDTreeToggle
             endif
         endfunction
         " toggle nerd tree
         nmap <silent> <leader>k :call ToggleNerdTree()<cr>
         " find the current file in nerdtree without needing to reload the drawer
         nmap <silent> <leader>y :NERDTreeFind<cr>
 
         let NERDTreeShowHidden=1
         " let NERDTreeDirArrowExpandable = 'â–·'
         " let NERDTreeDirArrowCollapsible = 'â–¼'
         let g:NERDTreeIndicatorMapCustom = {
         \ "Modified"  : "¹",
         \ "Staged"    : "",
         \ "Untracked" : "­",
         \ "Renamed"   : "",
         \ "Unmerged"  : "",
         \ "Deleted"   : "",
         \ "Dirty"     : "",
         \ "Clean"     : "",
         \ 'Ignored'   : '',
         \ "Unknown"   : "?"
         \ }
 
 call plug#end()
 
 " Colorscheme and final setup {{{
     set guifont=DroidSansMono\ Nerd\ Font\ 11
     set guifont=DroidSansMono\ Nerd\ Font:h11
 	syntax on
     filetype plugin indent on
     " make the highlighting of tabs and other non-text less annoying
     highlight SpecialKey ctermfg=19 guifg=#333333
     highlight NonText ctermfg=19 guifg=#333333
 
     " make comments and HTML attributes italic
     highlight Comment cterm=italic term=italic gui=italic
     highlight htmlArg cterm=italic term=italic gui=italic
     highlight xmlAttrib cterm=italic term=italic gui=italic
     " highlight Type cterm=italic term=italic gui=italic
     highlight Normal ctermbg=none
 
     colorscheme snazzy
     map <C-q> :q!<CR>
     map <C-s> :w!<CR>
     map <C-n> :NERDTreeToggle<CR>
     map <C-f> :FZF<CR>
