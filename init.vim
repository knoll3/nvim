" Vim settings
"
" Note: .vimrc in home directory is a symlink from ~/.vim/.vimrc
" Note: Make sure neovim/vim and node versions are compatible with Coc!
"
" Term Color Table
" https://jonasjacek.github.io/colors/
"
" Built from guide at https://techinscribed.com/how-to-set-up-vim-as-an-ide-for-react-and-typescript-in-2020/
" For matching color scheme in terminal, go to https://github.com/morhetz/gruvbox-contrib

" Disables an error raised by coc.nvim (intellisense for typescript) that asks
" you to upgrade vim to latest version. 
let g:coc_disable_startup_warning = 1

" Set the leader to the spacebar
let mapleader=" "

" This could cause problems but it's so annoying
" set noswapfile

" Using vim-plug as plugin manager. https://github.com/junegunn/vim-plug
call plug#begin()

	" ============================================================================
	" Color Schemes
	" ============================================================================
	"
	"https://github.com/morhetz/gruvbox
	" Plug 'morhetz/gruvbox' 
	Plug 'arcticicestudio/nord-vim'

	" ============================================================================

	" Regex based syntax highlighting for typescript
	" https://github.com/HerringtonDarkholme/yats.vim
	" Plug 'HerringtonDarkholme/yats.vim' 

	" Concrete syntax tree syntax highligting (much better highlighting).
	" IMPORTANT: Requires nightly nvim build to run. Only works with versions >= 0.5
	" https://github.com/nvim-treesitter/nvim-treesitter
	" Install new parsers with :TSInstall {language}
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

	" Intellisense for TypeScript
	" https://github.com/neoclide/coc.nvim
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	Plug 'vim-syntastic/syntastic'
	Plug 'tomlion/vim-solidity'

	" Nerdtree file explorer
	" https://github.com/preservim/nerdtree
	Plug 'preservim/nerdtree'

	" Git gutter, shows git info in gutter
	" https://github.com/airblade/vim-gitgutter
  Plug 'airblade/vim-gitgutter'

	" Fuzzy search
	" https://github.com/junegunn/fzf
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

	" Code commenter
	" https://github.com/preservim/nerdcommenter
	Plug 'preservim/nerdcommenter'

	" ESlint
	" https://vimawesome.com/plugin/eslint
	Plug 'eslint/eslint'

	" Prettier
	" https://github.com/prettier/vim-prettier
	Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

	" Completes brackets, parenthesis, etc. in code
	" https://github.com/jiangmiao/auto-pairs
	Plug 'jiangmiao/auto-pairs'

	" Surrounds selection with a character, like quotes
	" https://github.com/tpope/vim-surround
	Plug 'tpope/vim-surround'

	" Various git tools
	" https://github.com/tpope/vim-fugitive
	Plug 'tpope/vim-fugitive'

	" TODO: Add support for commenting jsx/tsx

call plug#end()

" ============================================================================
" Vim Syntastic
" ============================================================================

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump = 0

" ============================================================================
" Silver searcher (Ag)
" ============================================================================
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap ff :Ag<SPACE>
endif

" ============================================================================
" Tree sitter modules
" ============================================================================

" Highlight Module
"
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}
EOF

" Incremental Selection Module
"
lua <<EOF
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
EOF

" Indentation Module
"
lua <<EOF
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
EOF

" Folding Module
"
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" ============================================================================
" Theme selection
" ============================================================================

" syntax on
" hi Visual guibg=Grey

colorscheme nord
" colorscheme gruvbox
set termguicolors
" autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
" autocmd vimenter * hi SignColumn guibg=NONE ctermbg=NONE 
" autocmd vimenter * hi NonText guibg=NONE ctermbg=NONE 

" let g:gruvbox_invert_selection=0
" let g:gruvbox_sign_column='dark1'

" Modify color for Coc Shift+K menu
func! s:my_colors_setup() abort
	hi Pmenu ctermbg=235 gui=NONE
endfunc
augroup colorscheme_coc_setup | au!
    au ColorScheme * call s:my_colors_setup()
augroup END

" ============================================================================
" Custom theme colors
" ============================================================================
"
" Custom theme minified
" autocmd vimenter * hi TSProperty ctermfg=110
" autocmd vimenter * hi TSComment ctermfg=240

" Full Custom theme
" hi TSNumber ctermfg=177
" hi TSNumber ctermfg=183
" hi TSFunction ctermfg=87
" hi TSParameter ctermfg=152
" hi TSType ctermfg=60
" hi TSProperty ctermfg=110
" hi TSPunctDelimiter ctermfg=242
" hi TSPunctBracket ctermfg=242
" hi TSPunctSpecial ctermfg=242
" " for null
" hi TSConstBuiltin ctermfg=4
" hi TSString ctermfg=36
" hi TSStringRegex ctermfg=1
" hi TSMethod ctermfg=69
" hi TSConstructor ctermfg=4
" hi TSConditional ctermfg=69
" hi TSOperator ctermfg=242
" " const return let var
" hi TSKeyword ctermfg=4
" " new keyword
" hi TSKeywordOperator ctermfg=4
" " import from as
" hi TSInclude ctermfg=69 
" " things like window
" hi TSVariableBuiltin ctermfg=4
" hi TSComment ctermfg=240

" ============================================================================
" Key mappings
" ============================================================================

imap jj <Esc>
imap jk <Esc>

map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

" FZF key bindings
nnoremap <leader>f :FZF<CR>

" Exits search highlighting with esc
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" replace currently selected text with default register
" without yanking it
vnoremap p "_dP

" ============================================================================
" Vim settings
" ============================================================================

set tabstop=4
set softtabstop=0 
set expandtab 
set shiftwidth=4
set smarttab

set nowrap
" set tabstop=2
" set shiftwidth=2
set ttyfast
set relativenumber
" set autoindent

let &t_SI = "\<esc>[5 q"  " blinking I-beam in insert mode
let &t_SR = "\<esc>[3 q"  " blinking underline in replace mode
let &t_EI = "\<esc>[ q"  " default cursor (usually blinking block) otherwise

" Install new plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" ============================================================================
" Nerdtree settings
" ============================================================================

nnoremap <leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let g:NERDTreeWinPos = "right"
let NERDTreeIgnore = ['\.swp$']

" ============================================================================
" Nerd commenter settings
" ============================================================================

let NERDSpaceDelims=1

" ============================================================================
" Prettier settings
" ============================================================================

let g:prettier#config#use_tabs = 'false'
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
autocmd BufWritePre *.sol Prettier


" ============================================================================
" Intellisense settings
" ============================================================================

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

