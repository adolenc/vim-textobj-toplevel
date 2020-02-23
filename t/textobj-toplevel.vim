source t/common.vim


describe 'Two groups of imports'
  before
    call SetBufferContents([
    \   '',
    \   '',
    \   'import lib1',
    \   'import lib2',
    \   '',
    \   '',
    \   'import lib3',
    \   '',
    \ ])
  end

  it 'selects the first group of imports'
    Expect ExecuteTextObjFromLine(3, 'i') to_select_lines [3, 4]
    Expect ExecuteTextObjFromLine(4, 'i') to_select_lines [3, 4]
  end

  it 'selects the third import'
    Expect ExecuteTextObjFromLine(7, 'i') to_select_lines [7, 7]
  end
end

describe 'Python example'
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

  it 'selects the correct individual import'
    Expect ExecuteTextObjFromLine(1, 'i') to_select_lines [1, 2]
    Expect ExecuteTextObjFromLine(2, 'i') to_select_lines [1, 2]
  end

  it 'selects the entire first function'
    for linenr in range(5, 10)
      Expect ExecuteTextObjFromLine(linenr, 'i') to_select_lines [5, 10]
    endfor
  end

  it 'selects the entire second function'
    for linenr in range(12, 15)
      Expect ExecuteTextObjFromLine(linenr, 'i') to_select_lines [12, 15]
    endfor
  end

  it 'selects the invocation of a function'
    Expect ExecuteTextObjFromLine(17, 'i') to_select_lines [17, 17]
  end
end

describe 'C++ example'
  before
    call SetBufferContents([
    \   '#include <iostream>',
    \   '#include <string>',
    \   '',
    \   '',
    \   'int fn1(int i)',
    \   '{',
    \   '',
    \   '    std::cout << 1 << std::endl;',
    \   '',
    \   '    return 0;',
    \   '}',
    \   '',
    \   'int fn2(int i,',
    \   '        int j)',
    \   '{',
    \   '',
    \   '    std::cout << 2 << std::endl;',
    \   '',
    \   '    return 0;',
    \   '};',
    \ ])
  end

  it 'selects the two includes'
    Expect ExecuteTextObjFromLine(1, 'i') to_select_lines [1, 2]
    Expect ExecuteTextObjFromLine(2, 'i') to_select_lines [1, 2]
  end

  it 'selects the entire first function'
    for linenr in range(5, 11)
      Expect ExecuteTextObjFromLine(linenr, 'i') to_select_lines [5, 11]
    endfor
  end

  it 'selects the entire second function'
    for linenr in range(13, 20)
      Expect ExecuteTextObjFromLine(linenr, 'i') to_select_lines [13, 20]
    endfor
  end
end


describe 'Readme example'
  before
    call SetBufferContents([
    \   '@cache',
    \   'def fn(c):',
    \   '',
    \   '    if c > 3:',
    \   "        print('over 3')",
    \   '',
    \   "    print('not over 3')",
    \   '',
    \   'int fn2(int a,',
    \   '        int b)',
    \   '{',
    \   '    int c = a + b;',
    \   '',
    \   '    return c * 3;',
    \   '}',
    \   '',
    \   '',
    \   'c = fn2(1, 2)',
    \   'fn(c)',
    \ ])
  end

  it 'selects the entire first function'
    for linenr in range(1, 7)
      Expect ExecuteTextObjFromLine(linenr, 'i') to_select_lines [1, 7]
    endfor
  end

  it 'selects the entire second function'
    for linenr in range(9, 15)
      Expect ExecuteTextObjFromLine(linenr, 'i') to_select_lines [9, 15]
    endfor
  end

  it 'selects the invocation of a function'
    Expect ExecuteTextObjFromLine(18, 'i') to_select_lines [18, 19]
    Expect ExecuteTextObjFromLine(19, 'i') to_select_lines [18, 19]
  end

  it 'selects the trailing whitespace after first function'
    for linenr in range(1, 7)
      Expect ExecuteTextObjFromLine(linenr, 'a') to_select_lines [1, 8]
    endfor
  end

  it 'selects the trailing whitespace after second function'
    for linenr in range(9, 17)
      Expect ExecuteTextObjFromLine(linenr, 'a') to_select_lines [9, 17]
    endfor
  end

  it 'selects the preceding whitespace before the two function calls'
    Expect ExecuteTextObjFromLine(18, 'a') to_select_lines [16, 19]
    Expect ExecuteTextObjFromLine(19, 'a') to_select_lines [16, 19]
  end

end

describe 'Edgecase with only indented lines'
  before
    call SetBufferContents([
    \   '',
    \   '',
    \   '  import lib1',
    \   '  import lib2',
    \   '',
    \ ])
  end

  it 'selects all the lines until the top of the file'
    Expect ExecuteTextObjFromLine(3, 'i') to_select_lines [1, 4]
    Expect ExecuteTextObjFromLine(4, 'i') to_select_lines [1, 4]
  end
end

describe 'Edgecase with blank file'
  before
    call SetBufferContents([
    \   '',
    \ ])
  end

  it 'selects the blank line'
    Expect ExecuteTextObjFromLine(1, 'i') to_select_lines [1, 1]
  end
end

describe 'Edgecase with only unindented lines'
  before
    call SetBufferContents([
    \   'import lib1',
    \   'import lib2',
    \ ])
  end

  it 'selects all unindented lines'
    Expect ExecuteTextObjFromLine(1, 'i') to_select_lines [1, 2]
    Expect ExecuteTextObjFromLine(2, 'i') to_select_lines [1, 2]
  end
end
