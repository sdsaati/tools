function colors
  for i in (seq 0 255)
    printf "\e[48;5;%sm %3s \e[0m" $i $i
    if test (math "$i % 16") -eq 15
      echo
    end
  end
end
