if exists('g:loaded_textobj_toplevel')
  finish
endif

call textobj#user#plugin('toplevel', {
\      '-': {
\        'select-a': 'aT', '*select-a-function*': 'textobj#toplevel#select_a',
\        'select-i': 'iT', '*select-i-function*': 'textobj#toplevel#select_i',
\      }
\    })

let g:loaded_textobj_toplevel = 1
