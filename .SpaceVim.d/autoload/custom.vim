function GetSelectedText()
  normal y
  let selected_text = getreg('"')
  " Step 2: Write to a temporary file
  let temp_file = tempname()
  call writefile(split(selected_text, "\n"), temp_file)

  " Step 3: Use the file in system()
  let result = system('cat ' . temp_file)

  " Step 4: Clean up
  call delete(temp_file)
  return result
endfunction
