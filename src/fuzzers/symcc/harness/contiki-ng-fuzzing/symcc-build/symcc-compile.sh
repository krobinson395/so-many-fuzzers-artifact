#!/bin/bash

## AFL instrumentation
./../afl-build/${AFL_COMPANION}-compile.sh

echo
echo "Building the fuzzer with SymCC"
echo

make TARGET=native distclean 2>/dev/null
CFLAGS+=" -fPIE -fprofile-instr-generate -fcoverage-mapping"
LDFLAGS+=" -fprofile-instr-generate -fcoverage-mapping"

if [[ -z "${SYMCC_PATH}" ]]; then
  CC=symcc CFLAGS=${CFLAGS} LDFLAGS=${LDFLAGS} LD_OVERRIDE=symcc make TARGET=native ${HARNESS_NAME} WERROR=0
else
  CC=${SYMCC_PATH}/symcc_build/symcc CFLAGS=${CFLAGS} LD_OVERRIDE=${SYMCC_PATH}/symcc_build/symcc make TARGET=native ${HARNESS_NAME} WERROR=0
fi

mv ${HARNESS_NAME}.native bin/${HARNESS_NAME}.symcc
