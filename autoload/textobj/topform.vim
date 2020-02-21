function! textobj#topform#select_i()
  let topform = s:select_in_topform(line('.'))
  return s:encode_linerange(topform)
endfunction

function! textobj#topform#select_a()
  let topform = s:select_in_topform(line('.'))
  let topform = s:select_surrounding_blank_lines(topform)
  return s:encode_linerange(topform)
endfunction


function! s:encode_linerange(range)
  let [start_linenr, end_linenr] = a:range
  return ['V',
  \       [0, start_linenr, 1, 0],
  \       [0, end_linenr, len(getline(end_linenr)) + 1, 0]]
endfunction


function! s:above(linenr)
  return a:linenr - 1
endfunction

function! s:below(linenr)
  return a:linenr + 1
endfunction


function! s:is_inside_buffer(linenr)
  return line('^') < a:linenr && a:linenr <= line('$')
endfunction

function! s:is_blank(linenr)
  return getline(a:linenr) == ''
endfunction

function! s:is_unindented(linenr)
  return !s:is_blank(a:linenr) && (indent(a:linenr) == 0)
endfunction

function! s:is_start_of_topform(linenr)
  return s:is_unindented(a:linenr) && s:is_blank(s:above(a:linenr))
endfunction


function! s:find_topform_start(cursor_linenr)
  let start_linenr = a:cursor_linenr
  while s:is_inside_buffer(s:above(start_linenr)) && !s:is_start_of_topform(start_linenr)
    let start_linenr = s:above(start_linenr)
  endwhile
  return start_linenr
endfunction

function! s:find_topform_end(start_linenr)
  let next_topform_start_linenr = s:below(a:start_linenr)
  while s:is_inside_buffer(next_topform_start_linenr) && !s:is_start_of_topform(next_topform_start_linenr)
    let next_topform_start_linenr = s:below(next_topform_start_linenr)
  endwhile
  return prevnonblank(s:above(next_topform_start_linenr))
endfunction

function! s:select_in_topform(cursor_linenr)
  let start_linenr = s:find_topform_start(a:cursor_linenr)
  let end_linenr = s:find_topform_end(start_linenr)

  return [start_linenr, end_linenr]
endfunction

function! s:select_surrounding_blank_lines(range)
  let [start_linenr, end_linenr] = a:range

  let new_end = nextnonblank(s:below(end_linenr))
  if new_end != 0
    return [start_linenr, s:above(new_end)]
  else
    let new_start = prevnonblank(s:above(start_linenr))
    return [s:below(new_start), end_linenr]
  endif
endfunction
