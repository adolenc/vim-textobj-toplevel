runtime! plugin/textobj/*.vim

function! ExecuteTextObjFromLine(linenr, modifier)
  execute "normal! " . a:linenr . "G"
  execute "normal V" . a:modifier . "T\<Esc>"
  return [line("'<"), line("'>")]
endfunction

function! SetBufferContents(lines)
  tabnew
  tabonly!
  silent put =a:lines
  1 delete _
endfunction


function! ToSelectLines(actual, expected)
  return a:actual ==# a:expected
endfunction

function! FailedToSelectLines(actual, expected)
  let [astart, aend] = a:actual
  let [estart, eend] = a:expected
  return ['Actual value: ' . string(a:actual)]     + map(getline(astart, aend), '"| " . v:val') +
       \ ['Expected value: ' . string(a:expected)] + map(getline(estart, eend), '"| " . v:val')
endfunction

call vspec#customize_matcher('to_select_lines',
                            \{
                            \  'match': function('ToSelectLines'),
                            \  'failure_message_for_should': function('FailedToSelectLines')
                            \} )
