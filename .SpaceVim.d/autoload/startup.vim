function! startup#before() abort
  " here we can run our vim stuff (sdsaati):
  let g:mapleader = ','
  unlet! GetSelectedText
  source ~/.SpaceVim.d/autoload/custom.vim
  source ~/.SpaceVim.d/autoload/gpt.vim
  source ~/.SpaceVim.d/autoload/autoOnBuffers.vim
  nnoremap U <C-r>
  nnoremap # #N

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
endfunction
function! startup#after() abort
  " here we can run our vim stuff (sdsaati):
endfunction

