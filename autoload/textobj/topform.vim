function! textobj#topform#select_a()
  let topform = s:select_in_topform(line('.'))
  let topform = s:select_surrounding_blank_lines(topform)
  return s:encode_linerange(topform)
endfunction

function! textobj#topform#select_i()
  let topform = s:select_in_topform(line('.'))
  return s:encode_linerange(topform)
endfunction



function! s:first_line_satisfying(linenr, condition, direction)
  let base_linenr = a:linenr
  while s:is_inside_buffer(base_linenr) && !a:condition(base_linenr)
    let base_linenr += a:direction
  endwhile
  return base_linenr
endfunction

function! s:first_line_above(linenr, condition)
  return s:first_line_satisfying(a:linenr, s:to_fn(a:condition), -1)
endfunction

function! s:first_line_below(linenr, condition)
  return s:first_line_satisfying(a:linenr, s:to_fn(a:condition), 1)
endfunction

function! s:above(linenr)
  return a:linenr - 1
endfunction

function! s:below(linenr)
  return a:linenr + 1
endfunction


function! s:to_fn(a)
  if type(a:a) == type('')
    return function('s:' . a:a)
  else
    return a:a
  endif
endfunction

function! s:not(a)
  return {linenr -> !s:to_fn(a:a)(linenr)}
endfunction


function! s:is_inside_buffer(linenr)
  return line('^') < a:linenr && a:linenr <= line('$')
endfunction

function! s:is_empty(linenr)
  return getline(a:linenr) == ''
endfunction

function! s:is_indented(linenr)
  return !s:is_empty(a:linenr) && (indent(a:linenr) > 0)
endfunction

function! s:is_unindented(linenr)
  return !s:is_empty(a:linenr) && (indent(a:linenr) == 0)
endfunction


function! s:encode_linerange(range)
  let [start_linenr, end_linenr] = a:range
  return ['V',
  \       [0, start_linenr, 1, 0],
  \       [0, end_linenr, len(getline(end_linenr)) + 1, 0]]
endfunction

function! s:find_topform_start(cursor_linenr)
  let above_start_linenr = s:first_line_above(a:cursor_linenr, 'is_unindented')
  while s:is_inside_buffer(above_start_linenr) && !s:is_empty(above_start_linenr)
    let above_start_linenr = s:first_line_above(above_start_linenr, 'is_unindented')
    let above_start_linenr = s:first_line_above(s:above(above_start_linenr), s:not('is_unindented'))
  endwhile
  return s:below(above_start_linenr)
endfunction

function! s:find_topform_end(start_linenr)
  let end_linenr = a:start_linenr
  let next_topform_linenr = s:below(end_linenr)
  while s:is_inside_buffer(next_topform_linenr) && !s:is_empty(s:above(next_topform_linenr))
    let end_linenr = s:first_line_below(next_topform_linenr, s:not('is_unindented'))
    let next_topform_linenr = s:first_line_below(end_linenr, 'is_unindented')
  endwhile
  return s:first_line_above(s:above(next_topform_linenr), s:not('is_empty'))
endfunction

function! s:select_in_topform(cursor_linenr)
  " the algorithm assumes that each line in the file is exactly one of
  "   {is_indented, is_unindented, is_empty}
  let start_linenr = s:find_topform_start(a:cursor_linenr)
  let end_linenr = s:find_topform_end(start_linenr)

  return [start_linenr, end_linenr]
endfunction

function! s:select_surrounding_blank_lines(range)
  let [start_linenr, end_linenr] = a:range

  let new_end = s:first_line_below(s:below(end_linenr), s:not('is_empty'))
  if s:is_inside_buffer(new_end)
    return [start_linenr, s:above(new_end)]
  else
    let new_start = s:below(s:first_line_above(s:above(start_linenr), s:not('is_empty')))
    return [new_start, end_linenr]
  endif
endfunction
