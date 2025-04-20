.PHONY: run debug clean setup init

SRC = $(word 2,$(MAKECMDGOALS))

.SILENT:

run:
	sh scripts/run.sh $(SRC)

debug:
	sh scripts/debug.sh $(SRC)

clean:
	rm -rf build/*

setup:
	test -d build || mkdir -p build
	test -d io || mkdir -p io
	test -d scripts || mkdir -p scripts
	test -f compile_flags.txt || cp $(HOME)/.config/cp-template/compile_flags.txt .
	test -f .clangd || cp $(HOME)/.config/cp-template/.clangd .
	test -f .clang-format || cp $(HOME)/.config/cp-template/.clang-format .

init:
	make setup

%:
	@:
