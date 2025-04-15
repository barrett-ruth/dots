#!/bin/sh

. ./scripts/utils.sh

SRC="$1"
BASE=$(basename "$SRC" .cc)
INPUT="${BASE}.in"
OUTPUT="${BASE}.out"
DBG_BIN="${BASE}.debug"

DEBUG_FLAGS="-g3 -fsanitize=address,undefined \
    -fsanitize=float-divide-by-zero -fsanitize=float-cast-overflow \
    -fno-sanitize-recover=all -fstack-protector-all -fstack-usage \
    -fno-omit-frame-pointer -fno-inline -ffunction-sections \
    -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC"

test -d build || mkdir -p build
test -d io || mkdir -p io

test -f "$INPUT" && test ! -f "io/$INPUT" && mv "$INPUT" "io/"
test -f "$OUTPUT" && test ! -f "io/$OUTPUT" && mv "$OUTPUT" "io/"

test -f "io/$INPUT" || touch "io/$INPUT"
test -f "io/$OUTPUT" || touch "io/$OUTPUT"

INPUT="io/$INPUT"
OUTPUT="io/$OUTPUT"
DBG_BIN="build/$DBG_BIN"

compile_source "$SRC" "$DBG_BIN" "$OUTPUT" "$DEBUG_FLAGS"
CODE=$?
test $CODE -gt 0 && exit $CODE

execute_binary "$DBG_BIN" "$INPUT" "$OUTPUT"
exit $?
