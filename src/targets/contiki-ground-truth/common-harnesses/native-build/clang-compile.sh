#!/bin/bash
. ../contiki-setup.sh

echo
echo "Building the native fuzzing harness ${HARNESS_NAME} with clang"
echo

CFLAGS+=" -fPIE -fprofile-instr-generate -fcoverage-mapping"
LDFLAGS+="-fprofile-instr-generate -fcoverage-mapping"
CC=clang CFLAGS=${CFLAGS} LDFLAGS=${LDFLAGS} make TARGET=native ${HARNESS_NAME} WERROR=0

mkdir -p bin
mv ${HARNESS_NAME}.native bin/${HARNESS_NAME}.native-clang
