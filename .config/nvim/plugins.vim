" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

" editing
Plug 'ntpeters/vim-better-whitespace'
Plug 'rstacruz/vim-closer'
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/echodoc.vim'
Plug 'editorconfig/editorconfig-vim'

" git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" go
Plug 'fatih/vim-go'

" javascript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mxw/vim-jsx'
Plug 'heavenshell/vim-jsdoc'

" syntax
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'

" ui
Plug 'arcticicestudio/nord-vim'
" Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" misc
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-vinegar'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neomru.vim'
Plug 'vimwiki/vimwiki'

call plug#end()
