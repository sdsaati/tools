function fish_user_key_bindings
  fish_vi_key_bindings  # to make the fish using vim mode :)
  # bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
  bind -M insert -m default jk backward-char force-repaint
end
