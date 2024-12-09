function! file#before() abort
  " here we can run our vim stuff (sdsaati):
  let g:mapleader = ','
  unlet! GetSelectedText
  source ~/.SpaceVim.d/autoload/custom.vim
  source ~/.SpaceVim.d/autoload/gpt.vim
endfunction
function! file#after() abort
  " here we can run our vim stuff (sdsaati):
    nnoremap U <C-r>
endfunction

