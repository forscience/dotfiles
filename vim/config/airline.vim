" Always show airline & configure it
if has("gui")
  set laststatus=2
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
  function! AirlineInit()
      let g:airline_section_a = airline#section#create(['mode',' ','branch'])
      let g:airline_section_b = airline#section#create(['ffenc'])
      let g:airline_section_c = airline#section#create(['%t'])
      let g:airline_section_d = airline#section#create(['filetype'])
      let g:airline_section_x = airline#section#create(['%P'])
      let g:airline_section_y = airline#section#create(['%B'])
      let g:airline_section_z = airline#section#create_right(['%l, %c'])
  endfunction
  autocmd VimEnter * call AirlineInit()
endif
