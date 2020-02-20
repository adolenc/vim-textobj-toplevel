source t/common.vim
source plugin/textobj/topform.vim


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
    Expect ExecuteViTFromLine(3) to_select_lines [3, 4]
    Expect ExecuteViTFromLine(4) to_select_lines [3, 4]
  end

  it 'selects the third import'
    Expect ExecuteViTFromLine(7) to_select_lines [7, 7]
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
    Expect ExecuteViTFromLine(1) to_select_lines [1, 2]
    Expect ExecuteViTFromLine(2) to_select_lines [1, 2]
  end

  it 'selects the entire first function'
    for linenr in range(5, 10)
      Expect ExecuteViTFromLine(linenr) to_select_lines [5, 10]
    endfor
  end

  it 'selects the entire second function'
    for linenr in range(12, 15)
      Expect ExecuteViTFromLine(linenr) to_select_lines [12, 15]
    endfor
  end

  it 'selects the invocation of a function'
    Expect ExecuteViTFromLine(17) to_select_lines [17, 17]
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
    Expect ExecuteViTFromLine(1) to_select_lines [1, 2]
    Expect ExecuteViTFromLine(2) to_select_lines [1, 2]
  end

  it 'selects the entire first function'
    for linenr in range(5, 11)
      Expect ExecuteViTFromLine(linenr) to_select_lines [5, 11]
    endfor
  end

  it 'selects the entire second function'
    for linenr in range(13, 20)
      Expect ExecuteViTFromLine(linenr) to_select_lines [13, 20]
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
    \   '    c = a + b;',
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
      Expect ExecuteViTFromLine(linenr) to_select_lines [1, 7]
    endfor
  end

  it 'selects the entire second function'
    for linenr in range(9, 15)
      Expect ExecuteViTFromLine(linenr) to_select_lines [9, 15]
    endfor
  end

  it 'selects the invocation of a function'
    Expect ExecuteViTFromLine(18) to_select_lines [18, 19]
    Expect ExecuteViTFromLine(19) to_select_lines [18, 19]
  end
end
