runtime! plugin/textobj/*.vim
version


describe 'The plugin'
  it 'is loaded'
    Expect exists('g:loaded_textobj_topform') to_be_true
  end
end

describe 'Named key mappings'
  it 'is available in proper modes'
    for lhs in ['<Plug>(textobj-topform-a)',
    \           '<Plug>(textobj-topform-i)']
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
    Expect maparg('aT', 'o') ==# '<Plug>(textobj-topform-a)'
    Expect maparg('aT', 'v') ==# '<Plug>(textobj-topform-a)'
    Expect maparg('iT', 'c') ==# ''
    Expect maparg('iT', 'i') ==# ''
    Expect maparg('iT', 'n') ==# ''
    Expect maparg('iT', 'o') ==# '<Plug>(textobj-topform-i)'
    Expect maparg('iT', 'v') ==# '<Plug>(textobj-topform-i)'
  end
end
