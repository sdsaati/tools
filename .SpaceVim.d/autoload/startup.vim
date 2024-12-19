function! startup#before() abort
  " here we can run our vim stuff (sdsaati):
  let g:mapleader = ','
  unlet! GetSelectedText
  source ~/.SpaceVim.d/autoload/custom.vim
  source ~/.SpaceVim.d/autoload/gpt.vim
  source ~/.SpaceVim.d/autoload/autoOnBuffers.vim
  nnoremap U <C-r>
  nnoremap # #N
  call SpaceVim#custom#SPC('nnoremap', ['/'], 'Vista!!', 'show outlines using ctags (Vista!!)', 1)
endfunction
function! startup#after() abort
  " here we can run our vim stuff (sdsaati):
endfunction

