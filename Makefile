update_bats:
	git submodule update --init --recursive

tests:
	./bats/bats/bin/bats test/**/*.bats

lint:
	shellcheck **/*.sh
