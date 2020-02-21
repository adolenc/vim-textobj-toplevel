vim-textobj-toplevel
===================
[![Build Status](https://travis-ci.com/adolenc/vim-textobj-toplevel.svg?branch=master)](https://travis-ci.com/adolenc/vim-textobj-toplevel)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)

vim-textobj-toplevel is a (neo)vim plugin defining a new textobject: 'top-level
block', bound to <kbd>T</kbd> by default. It is great for sending pieces of code
to a REPL, or moving logical chunks of code around the file in arbitrary
programming language.

## Example
Consider the following example, a mix between dummy Python and C code.
The lines on the left-hand side represent the code selected by <kbd>aT</kbd>
and <kbd>iT</kbd> bindings:

```
aT iT
┌  ┌  @cache
│  │  def fn(c):
│  │  
│  │      if c > 3:
│  │          print('over 3')
│  │  
│  └      print('not over 3')
└     
┌  ┌  int fn2(int a,
│  │          int b)
│  │  {
│  │      int c = a + b;
│  │  
│  │      return c * 3;
│  └  } // part of top-level block because line above is not blank
│     
└     
┌  ┌  c = fn2(1, 2)
└  └  fn(c)
```

Intuitively a top-level block can be thought of as a paragraph
that takes indentation into account: a new top-level block starts at the
first non-indented line following a blank line, and spans all the lines until
the next top-level block. In most ('nicely' formatted) source files this
covers definitions of functions, classes, include statements, individual
assignments and invocations at top level, etc.

vim-textobj-toplevel tries to mimic the built-in paragraph text object, with
<kbd>iT</kbd> selecting the top-level block from anywhere within it, and
<kbd>aT</kbd> selecting the top-level block and the trailing blank lines.

## Installation
This plugin depends on Kana's
[vim-textobj-user](https://github.com/kana/vim-textobj-user). If you are using
[vim-plug](https://github.com/junegunn/vim-plug), add following lines to your
`vimrc`:

```
Plug 'adolenc/vim-textobj-toplevel' | Plug 'kana/vim-textobj-user'
```
