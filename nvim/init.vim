"vim plug
call plug#begin()
    Plug 'vim-airline/vim-airline'
    Plug 'ghifarit53/tokyonight-vim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'lervag/vimtex'
    Plug 'aklt/plantuml-syntax'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

set number
set relativenumber

set showmatch
set showcmd

set smartindent

set tabstop=4
set shiftwidth=4

set smarttab
set noexpandtab

"theme
set termguicolors
let g:tokyonight_style = 'night'
colorscheme tokyonight

"airline theme
let g:airline_theme = 'tokyonight'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

"vimtex
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'

"some keybinds - disabling arrow keys
for key in ['<up>', '<down>', '<left>', '<right>']
    exec 'nnoremap' key '<nop>'
    exec 'inoremap' key '<nop>'
    exec 'vnoremap' key '<nop>'
endfor

set clipboard+=unnamedplus

"setting space as the leader key
nnoremap <space> <nop>
let mapleader="\<space>"

lua << EOF
require'nvim-treesitter.configs'.setup {
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require("nvim-tree").setup()

-- keybinds for lspconfig and cmp
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- Set up lspconfig.
local lsp_flags = {
  debounce_text_changes = 150,
}

-- used language servers need to be installed and usable on the system

-- https://github.com/microsoft/pyright
require('lspconfig')['pyright'].setup {
	on_attach = on_attach,
    flags = lsp_flags,
}

-- https://github.com/razzmatazz/csharp-language-server
require('lspconfig')['csharp_ls'].setup {
	on_attach = on_attach,
    flags = lsp_flags,
}

-- https://clangd.llvm.org/installation.html
require('lspconfig')['clangd'].setup{
	on_attach = on_attach,
    flags = lsp_flags,
}

-- https://github.com/FractalBoy/perl-language-server
require('lspconfig')['perlpls'].setup{
	on_attach = on_attach,
    flags = lsp_flags,
}

local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  }),
  sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
  },
}

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = ''})

EOF
