if exists('g:loaded_textobj_topform')
  finish
endif

call textobj#user#plugin('topform', {
\      '-': {
\        'select-a': 'aT', '*select-a-function*': 'textobj#topform#select_a',
\        'select-i': 'iT', '*select-i-function*': 'textobj#topform#select_i',
\      }
\    })

let g:loaded_textobj_topform = 1
