vim-textobj-topform
===================
[![Build Status](https://travis-ci.com/adolenc/vim-textobj-topform.svg?branch=master)](https://travis-ci.com/adolenc/vim-textobj-topform)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)

vim-textobj-topform is a (neo)vim plugin defining a new textobject: 'top-level
form', bound to <kbd>T</kbd> by default. It is great for sending pieces of code
to a REPL, or moving logical chunks of code around the file in arbitrary
programming language.

Intuitively a top-level form ('topform') can be thought of as a paragraph that
takes indentation into account: a new topform starts at the first non-indented
line following an empty line, and spans all the lines until the next topform.
In most ('nicely' formatted) source files this covers definitions of functions,
classes, include statements, individual assignments and invocations at top
level, etc.

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
│  │      c = a + b;
│  │  
│  │      return c * 3;
│  └  } // part of topform because line above is not empty
│     
└     
┌  ┌  c = fn2(1, 2)
└  └  fn(c)
```

vim-textobj-topform tries to mimic the built-in paragraph text object, with
<kbd>iT</kbd> selecting the topform from anywhere within it, and <kbd>aT</kbd>
selecting the topform as well as the trailing empty lines until the next
topform.

## Installation
This plugin depends on Kana's
[vim-textobj-user](https://github.com/kana/vim-textobj-user). If you are using
[vim-plug](https://github.com/junegunn/vim-plug), add following lines to your
`vimrc`:

```
Plug 'adolenc/vim-textobj-topform' | Plug 'kana/vim-textobj-user'
```
