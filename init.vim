" START: VIM-Plug plugins
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdcommenter'
Plug 'b3nj5m1n/kommentary'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'psliwka/vim-smoothie'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yamatsum/nvim-cursorline'
Plug 'windwp/nvim-autopairs'
Plug 'p00f/nvim-ts-rainbow'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'nvim-lua/plenary.nvim'
Plug 'TimUntersberger/neogit'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'neovim/nvim-lspconfig'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.3' }
Plug 'nosduco/remote-sshfs.nvim'
call plug#end()
" END: VIM-Plug plugins
set encoding=UTF-8
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
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>
" symbol renaming
nmap <F2> <Plug>(coc-rename)
" fuzzy file finder
nmap ff :Files<CR>
nmap fg :GFiles<CR>
" neogit binds
nmap <space>c :Neogit<CR>
nmap <space>p :Neogit push<CR>
" test
nmap rc :RemoteSSHFSConnect<CR>
nmap rd :RemoteSSHFSDisconnect<CR>
nmap re :RemoteSSHFSEdit<CR>
" END: Custom keybinds
"----

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

require('remote-sshfs').setup({})
require('telescope').load_extension 'remote-sshfs'

local api = require('remote-sshfs.api')

-- (optional) Override telescope find_files and live_grep to make dynamic based on if connected to host
local builtin = require("telescope.builtin")
local connections = require("remote-sshfs.connections")
vim.keymap.set("n", "<leader>ff", function()
	if connections.is_connected then
		api.find_files()
	else
		builtin.find_files()
	end
end, {})
vim.keymap.set("n", "<leader>fg", function()
	if connections.is_connected then
		api.live_grep()
	else
		builtin.live_grep()
	end
end, {})

require('remote-sshfs').setup{
  connections = {
    ssh_configs = { -- which ssh configs to parse for hosts list
      vim.fn.expand "$HOME" .. "/.ssh/config",
      "/etc/ssh/ssh_config",
      -- "/path/to/custom/ssh_config"
    },
    sshfs_args = { -- arguments to pass to the sshfs command
      "-o reconnect",
      "-o ConnectTimeout=5",
    },
  },
  mounts = {
    base_dir = vim.fn.expand "$HOME" .. "/.sshfs/", -- base directory for mount points
    unmount_on_exit = true, -- run sshfs as foreground, will unmount on vim exit
  },
  handlers = {
    on_connect = {
      change_dir = true, -- when connected change vim working directory to mount point
    },
    on_disconnect = {
      clean_mount_folders = false, -- remove mount point folder on disconnect/unmount
    },
    on_edit = {}, -- not yet implemented
  },
  ui = {
    select_prompts = false, -- not yet implemented
    confirm = {
      connect = true, -- prompt y/n when host is selected to connect to
      change_dir = false, -- prompt y/n to change working directory on connection (only applicable if handlers.on_connect.change_dir is enabled)
    },
  },
  log = {
    enable = false, -- enable logging
    truncate = false, -- truncate logs
    types = { -- enabled log types
      all = false,
      util = false,
      handler = false,
      sshfs = false,
    },
  },
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
" END: functions
