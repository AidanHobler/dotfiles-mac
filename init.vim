call plug#begin("~/.config/nvim/plugged")
  " Plugin Section
    Plug 'preservim/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'Xuyuanp/nerdtree-git-plugin' 
    Plug 'ryanoasis/vim-devicons' 
    Plug 'morhetz/gruvbox'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'OmniSharp/omnisharp-vim'
    Plug 'dense-analysis/ale'
    Plug 'itchyny/lightline.vim'
    Plug 'vhyrro/neorg' | Plug 'nvim-lua/plenary.nvim'
    " Plug 'hrsh7th/nvim-compe'
    " Plug 'tree-sitter/tree-sitter'
    Plug 'justinmk/vim-sneak'
    " Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()
" Everything after this line will be the config section

" Set mapleader first so it works in plugins
let mapleader = " "

if (has("termguicolors"))
 set termguicolors
endif
set background=dark
colorscheme gruvbox

set number

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set tabstop=4 shiftwidth=4 expandtab

map <leader>w <C-w>
nnoremap <leader>b :buffers<CR>:buffer<Space>

" ****************************** Sneak ****************************** 
let g:sneak#label = 1

" ****************************** Compe ****************************** 
"set completeopt=menuone,noselect
"
"let g:compe = {}
"let g:compe.enabled = v:true
"let g:compe.autocomplete = v:true
"let g:compe.debug = v:false
"let g:compe.min_length = 1
"let g:compe.preselect = 'enable'
"let g:compe.throttle_time = 80
"let g:compe.source_timeout = 200
"let g:compe.resolve_timeout = 800
"let g:compe.incomplete_delay = 400
"let g:compe.max_abbr_width = 100
"let g:compe.max_kind_width = 100
"let g:compe.max_menu_width = 100
"let g:compe.documentation = v:true
"
"let g:compe.source = {}
"let g:compe.source.path = v:true
"let g:compe.source.neorg = v:true
"let g:compe.source.buffer = v:true
"let g:compe.source.calc = v:true
"let g:compe.source.nvim_lsp = v:true
"let g:compe.source.nvim_lua = v:true
"let g:compe.source.vsnip = v:true
"let g:compe.source.ultisnips = v:true
"let g:compe.source.luasnip = v:true
"let g:compe.source.emoji = v:true

" ****************************** Neorg ****************************** 
"
lua << EOF
--local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
--
--parser_configs.norg = {
--    install_info = {
--        url = "https://github.com/vhyrro/tree-sitter-norg",
--        files = { "src/parser.c" },
--        branch = "main"
--    },
--}
--
--require('nvim-treesitter.configs').setup {
--	ensure_installed = { "norg", "cpp", "c", "javascript"},
--}

require('neorg').setup {
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.norg.concealer"] = {}, -- Allows for use of icons
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
                workspaces = {
                    my_workspace = "~/neorg"
                }
            }
        }
    },
}
EOF

" ****************************** NERDTree ****************************** 
let g:NERDTreeShowHidden = 1 
let g:NERDTreeMinimalUI = 1 " hide helper
let g:NERDTreeIgnore = ['^node_modules$', '\.meta$'] " ignore node_modules to increase load speed 
let g:NERDTreeStatusline = '' " set to empty to use lightline
" " Toggle
noremap <silent> <C-b> :NERDTreeToggle<CR>
" " Close window if NERDTree is the last one
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" " Map to open current file in NERDTree and set size
nnoremap <leader>pv :NERDTreeFind<bar> :vertical resize 45<CR>

" NERDTree Syntax Highlight
" " Enables folder icon highlighting using exact match
let g:NERDTreeHighlightFolders = 1 
" " Highlights the folder name
let g:NERDTreeHighlightFoldersFullName = 1 
" " Color customization
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
" " This line is needed to avoid error
let g:NERDTreeExtensionHighlightColor = {} 
" " Sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['css'] = s:blue 
" " This line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor = {} 
" " Sets the color for .gitignore files
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange 
" " This line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor = {} 
" " Sets the color for files ending with _spec.rb
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red 
" " Sets the color for folders that did not match any rule
let g:WebDevIconsDefaultFolderSymbolColor = s:beige 
" " Sets the color for files that did not match any rule
let g:WebDevIconsDefaultFileSymbolColor = s:blue 

" ****************************** NERDTree Git Plugin ****************************** 
let g:NERDTreeStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }



" Prevent ale from running all linters at once
let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}


let g:OmniSharp_selector_ui = 'fzf'    " Use fzf
let g:OmniSharp_selector_findusages = 'fzf'


" ****************************** Lightline ****************************** 
let g:lightline = {
  \     'colorscheme': 'powerlineish',
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \     }
  \ }

" ****************************** END PLUGINS ****************************** 

