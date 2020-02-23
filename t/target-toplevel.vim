source t/common.vim
runtime! plugin/targets.vim


describe 'Target n modifiers'
  before
    call SetBufferContents([
    \   'import lib1',
    \   'import lib2',
    \   '',
    \   '',
    \   '@cache',
    \   'def fn(i):',
    \   '',
    \   '    \"ok\"',
    \   '',
    \   '    return fn(i-1)',
    \   '',
    \   '@cache',
    \   'def test2(i):',
    \   '    \"ok\"',
    \   '    return test2(i-1)',
    \ ])
  end

  it 'in selects first function from first imports'
    Expect ExecuteTextObjFromLine(1, 'in') to_select_lines [5, 10]
    Expect ExecuteTextObjFromLine(2, 'in') to_select_lines [5, 10]
  end

  it 'in selects second function from first function'
    for linenr in range(5, 10)
      Expect ExecuteTextObjFromLine(linenr, 'in') to_select_lines [12, 15]
    endfor
  end
end

describe 'Target l modifiers'
  before
    call SetBufferContents([
    \   'import lib1',
    \   'import lib2',
    \   '',
    \   '',
    \   '@cache',
    \   'def fn(i):',
    \   '',
    \   '    \"ok\"',
    \   '',
    \   '    return fn(i-1)',
    \   '',
    \   '@cache',
    \   'def test2(i):',
    \   '    \"ok\"',
    \   '    return test2(i-1)',
    \   '',
    \   'fn(2)',
    \ ])
  end

  it 'il selects imports from first function'
    for linenr in range(5, 10)
      Expect ExecuteTextObjFromLine(linenr, 'il') to_select_lines [1, 2]
    endfor
  end

  it 'il selects first function from second function'
    for linenr in range(12, 15)
      Expect ExecuteTextObjFromLine(linenr, 'il') to_select_lines [5, 10]
    endfor
  end
end
