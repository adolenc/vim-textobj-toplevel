.PHONY: test-dependencies tests

tests:
	dependencies/vim-vspec/bin/prove-vspec -d . -d dependencies/vim-textobj-user

test-dependencies:
	-mkdir dependencies
	-git clone https://github.com/kana/vim-vspec dependencies/vim-vspec
	-git clone https://github.com/kana/vim-textobj-user dependencies/vim-textobj-user
