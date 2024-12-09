function Gpt(prompt)
  " Get the full path of the current buffer
  let file = expand('%:p')
  split new
  resize 12  " Adjust the window height to 10 lines
  setlocal nobuflisted
  setlocal bufhidden=wipe
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal filetype=markdown
  setlocal wrap               " Enable line wrapping
  syntax on
  let output = system('echo "' . a:prompt . '" | cat - ' . file . ' | tgpt')
  let charsToRemove = ['⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷', '', "  Loading"]
  for theChar in charsToRemove
    let output = substitute(output, theChar, '', 'g')
  endfor

  call setline(1, split(trim(output), "\n"))
  stopinsert
endfunction
command! Gpt call Gpt("please tell me how an expert software engineer write this code: ")<CR>
call SpaceVim#custom#SPC('nnoremap', ['a', ','], 'Gpt', 'How can I write this better?', 1)


function GptUnitTest(prompt)
" Get the full path of the current buffer
  let file = expand('%:p')
  split new
  resize 12  " Adjust the window height to 10 lines
  setlocal nobuflisted
  setlocal bufhidden=wipe
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal filetype=markdown
  setlocal wrap               " Enable line wrapping
  syntax on
  let output = system('echo "' . a:prompt . '" | cat - ' . file . ' | tgpt')
  let charsToRemove = ['⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷', '', "  Loading"]
  for theChar in charsToRemove
    let output = substitute(output, theChar, '', 'g')
  endfor
  call setline(1, split(output, "\n"))
  stopinsert
endfunction
command! GptUnitTest call GptUnitTest("please write unit tests for this code: ")<CR>
call SpaceVim#custom#SPC('nnoremap', ['a', 't'], 'GptUnitTest', 'can you write unit tests for me?', 1)


function Chat()
  " Get the full path of the current buffer
  let file = expand('%:p')
  let prompt = input("Enter Prompt: ")
  split new
  resize 12  " Adjust the window height to 10 lines
  setlocal nobuflisted
  setlocal bufhidden=wipe
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal filetype=markdown
  setlocal wrap               " Enable line wrapping
  syntax on
  let output = system('echo "by having the below code, ' . trim(prompt) . ' the code starts here:\n" | cat - ' . file . ' | tgpt')
  let charsToRemove = ['⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷', '', "  Loading"]
  for theChar in charsToRemove
    let output = substitute(output, theChar, '', 'g')
  endfor
  call setline(1, split(trim(output), "\n"))
  stopinsert
endfunction
command! Chat call Chat()<CR>
call SpaceVim#custom#SPC('nnoremap', ['a', 'c'], 'Chat', 'chat with gpt for file', 1)


function! ChatSelection()
  " Get the full path of the current buffer
  let prompt = input("Enter Prompt: ")
  let selection = GetSelectedText()
  split new
  resize 12  " Adjust the window height to 10 lines
  setlocal nobuflisted
  setlocal bufhidden=wipe
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal filetype=markdown
  setlocal wrap               " Enable line wrapping
  syntax on 
  let charsToRemove = ['⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷', '', "  Loading"]
  for theChar in charsToRemove
    let selection = substitute(selection, theChar, '', 'g')
  endfor
  let charsToRemove = ['"', "'", '!', '(', ')', '#', '*']
  for charr in charsToRemove
    let selection = substitute(selection, charr, '\\'.charr, 'g')
  endfor
  let cmd = printf('echo -en "by having the below code, %s the code starts here: %s" | tgpt', trim(prompt), trim(selection))
  let output = system(cmd)
  let charsToRemove = ['⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷', '', "  Loading"]
  for theChar in charsToRemove
    let output = substitute(output, theChar, '', 'g')
  endfor
  call setline(1, split(trim(output), "\n"))
  stopinsert
endfunction
command! ChatSelection call ChatSelection()<CR>
call SpaceVim#custom#SPC('nnoremap', ['a', 's'], 'ChatSelection', 'chat with gpt about selected texts', 1)


