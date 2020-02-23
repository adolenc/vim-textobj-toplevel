runtime! plugin/textobj/*.vim


describe 'The plugin'
  it 'is loaded'
    Expect exists('g:loaded_textobj_toplevel') to_be_true
  end
end

describe 'Named key mappings'
  it 'is available in proper modes'
    for lhs in ['<Plug>(textobj-toplevel-a)',
    \           '<Plug>(textobj-toplevel-i)']
      Expect maparg(lhs, 'c') == ''
      Expect maparg(lhs, 'i') == ''
      Expect maparg(lhs, 'n') == ''
      Expect maparg(lhs, 'o') != ''
      Expect maparg(lhs, 'v') != ''
    endfor
  end
end

describe 'Default key mappings'
  it 'is available in proper modes'
    Expect maparg('aT', 'c') ==# ''
    Expect maparg('aT', 'i') ==# ''
    Expect maparg('aT', 'n') ==# ''
    Expect maparg('aT', 'o') ==# '<Plug>(textobj-toplevel-a)'
    Expect maparg('aT', 'v') ==# '<Plug>(textobj-toplevel-a)'
    Expect maparg('iT', 'c') ==# ''
    Expect maparg('iT', 'i') ==# ''
    Expect maparg('iT', 'n') ==# ''
    Expect maparg('iT', 'o') ==# '<Plug>(textobj-toplevel-i)'
    Expect maparg('iT', 'v') ==# '<Plug>(textobj-toplevel-i)'
  end
end
