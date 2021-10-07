" START: VIM-Plug plugins
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdcommenter'
Plug 'b3nj5m1n/kommentary'
Plug 'Yggdroot/indentLine'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'ryanoasis/vim-devicons'
Plug 'psliwka/vim-smoothie'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yamatsum/nvim-cursorline'
Plug 'windwp/nvim-autopairs'
Plug 'p00f/nvim-ts-rainbow'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'monaqa/dial.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'TimUntersberger/neogit'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'omnisharp/omnisharp-vim'
Plug 'neovim/nvim-lspconfig'

call plug#end()
" END: VIM-Plug plugins

" START: Basic vim configuration
" prevent netrw explorer loading on startup
let loaded_netrwPlugin=1
set number
set number relativenumber
syntax on
" set cursor at mouse click location
set mouse=a
" set tab size to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
" disable autocomment on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
 "enable autocomplete
set wildmode=longest,list,full
" remove trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e
" auto open coc-explorer on startup
" if a file was opened we skip opening explorer
if expand('%:t') == ""
  autocmd VimEnter * CHADopen .
endif
" improve ux
set updatetime=300
" set indentLine settings
let g:indentLine_char = "|"
let g:indentLine_color_term = 111
" chadtree settings
let g:chadtree_settings = { "view.width": 30, "theme.text_colour_set": "nord" }
" clipboard
set clipboard=unnamedplus
" END: Basic vim configuration

" START: Syntax highlighting configuration
au BufNewFile,BufRead *.hbs set filetype=html
" END: Syntax highlighting confuguration

" START: Custom keybinds
let mapleader = " "
" Resize window splits
nnoremap <silent> <C-A-Up> :resize +5<CR>
nnoremap <silent> <C-A-Down> :resize -5<CR>
nnoremap <silent> <C-A-Left> :vertical resize -5<CR>
nnoremap <silent> <C-A-Right> :vertical resize +5<CR>
"set nerdcommenter toggle to usual keybind
nmap <C-c> <Plug>NERDCommenterToggle
vmap <C-c> <Plug>NERDCommenterToggle<CR>gv
"Move between windows inside vim
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
"CTRL-S to save files
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>
" copy selection to clipboard
vnoremap <C-k> "*y
" close all buffers and exit
nmap <silent> <C-e> :qa<CR>
" navigate with hjkl in insert mode
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
" use tab for indent
nmap >> <Nop>
nmap << <Nop>
vmap >> <Nop>
vmap << <Nop>
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>
" symbol renaming
nmap <F2> <Plug>(coc-rename)
" fuzzy file finder
nmap ff :Files<CR>
nmap fg :GFiles<CR>
" dial.nvim binds
nmap <C-Up> <Plug>(dial-increment)
nmap <C-Down> <Plug>(dial-decrement)
" neogit binds
nmap <space>c :Neogit<CR>
nmap <space>p :Neogit push<CR>
" md preview toggle
nmap <C-p> <Plug>MarkdownPreviewToggle
" Open terminal and run current file upon call
nnoremap <C-R> :call Termpy() <CR>
" END: Custom keybinds
"----
" START: Editor colorscheme
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme palenight
" END: Editor colorscheme

" START: lua stuff
lua <<EOF
require('nvim-autopairs').setup()

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}

require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}

require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
  }
}

local neogit = require('neogit')

neogit.setup {}

EOF
" END: lua stuff
" START: functions
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

function! Termpy()
  exec winheight(0)/4."split" | terminal python3 %
endfunction
" END: functions
