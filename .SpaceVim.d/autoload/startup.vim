function! startup#before() abort
  " here we can run our vim stuff (sdsaati):
  let g:mapleader = ','
  unlet! GetSelectedText
  source ~/.SpaceVim.d/autoload/custom.vim
  source ~/.SpaceVim.d/autoload/gpt.vim
  source ~/.SpaceVim.d/autoload/autoOnBuffers.vim
  nnoremap U <C-r>
  nnoremap # #N
  set ignorecase
  set smartcase
  " =====[[ transparent bg========
  autocmd vimenter * highlight Normal guibg=NONE
  autocmd vimenter * highlight NonText guibg=NONE
  autocmd vimenter * highlight Normal ctermbg=NONE
  autocmd vimenter * highlight NonText ctermbg=NONE
  " For Vim<8, replace EndOfBuffer by NonText
  autocmd vimenter * highlight EndOfBuffer guibg=NONE ctermbg=none
  " =====transparent bg ]]========
  " Set cursor shape for terminal Vim
  let &t_SI = "\e[6 q"  " I-beam cursor in Insert mode
  let &t_EI = "\e[2 q"  " Block cursor in Normal mode

" makes scroll of documentation of lsp be ctrl+j and ctrl+k
nmap <C-j> <C-f>
nmap <C-k> <C-b>
imap <C-j> <C-f>
imap <C-k> <C-b>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! :w !sudo -A tee % 2>/dev/null<CR>

call feedkeys("\<space>wl")

" makes selected line be always at the center of screen
:set scrolloff=3 

call SpaceVim#custom#SPC('nnoremap', ['/'], 'Vista!!', 'show outlines using ctags (Vista!!)', 1)



lua << EOF
    local opt = requires('spacevim.opt')
    opt.enable_projects_cache = false
    opt.enable_statusline_mode = true
EOF

endfunction
function! startup#after() abort
  " here we can run our vim stuff (sdsaati):
lua << EOF
    local opt = requires('spacevim.opt')
    opt.enable_projects_cache = false
    opt.enable_statusline_mode = true
EOF
endfunction

