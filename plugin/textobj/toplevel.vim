if exists('g:loaded_textobj_toplevel')
  finish
endif

call textobj#user#plugin('toplevel', {
\      '-': {
\        'select-a': 'aT', '*select-a-function*': 'textobj#toplevel#select_a',
\        'select-i': 'iT', '*select-i-function*': 'textobj#toplevel#select_i',
\      }
\    })


autocmd User targets#sources call targets#sources#register('toplevel', function('textobj#toplevel#target_new'))
autocmd User targets#mappings#plugin call targets#mappings#extend({'T': {'toplevel': [{}]}})

let g:loaded_textobj_toplevel = 1
