.PHONY: run debug clean setup init

CXX = g++
# lefticus.gitbooks.io/cpp-best-practice
CXXFLAGS := -O2 -Wall -Wextra -Wpedantic -Wshadow -Wformat=2 \
	-Wfloat-equal -Wlogical-op -Wshift-overflow=2 -Wnon-virtual-dtor \
	-Wold-style-cast -Wcast-equal -Wuseless-cast -Wno-sign-promotion \
	-Wcast-align -Wunused -Woverloaded-virtual -Wconversion \
	-Wsign-conversion -Wmisleading-indentation -Wduplicated-cond \
	-Wduplicated-branches -Wlogical-op -Wnull-dereference -Wformat=2 \
	-Wformat-overflow -Wformat-truncation -Wdouble-promotion -Wundef \
	-DLOCAL -std=c++20

SRC = $(word 2,$(MAKECMDGOALS))

.SILENT:

run: 
	sh scripts/run.sh $(SRC)

debug: 
	sh scripts/debug.sh $(SRC)

clean:
	rm -rf build/*.run build/*.debug build/*.su io/*.out

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