#!/bin/bash

unset TIMEOUT
if [ $# -lt 1 ]; then echo "Error: need at least a timeout as its first parameter"; exit 1; fi
TIMEOUT=$1

## Fuzz
mkdir -p ${LOG_PATH}
echo "Start trial at: $(date -u '+%s')" > ${LOG_PATH}/start_time
timeout ${TIMEOUT} ./run-trial.sh -q
echo "End trial at: $(date -u '+%s')" > ${LOG_PATH}/end_time

## Check Fuzzers' output
./validate.sh
mkdir ${SHARED}/testPath
mkdir ${SHARED}/coverageData
touch ${SHARED}/testPath/testFile
echo "${LLVM_PROFILE_FILE}" >> testFile
echo "${TEST_VAR}" >> testFile
mkdir ${SHARED}/contikiBinary
cp -r ${SOFTWARE_PATH}/contikiBinary ${SHARED}/contikiBinary
#mkdir ${SHARED}/contikiBinary
#cp bin/${HARNESS_NAME}.symcc ${SHARED}/contikiBinary
## Finally move fuzzer data into usual sync_folder if TMPFS_PATH
## Note: not executed with "container stop"
if [ ! -z "${TMPFS_PATH}" ]; then
  mkdir ${SHARED}/sync_folder
  mv ${TMPFS_PATH}/* ${SHARED}/sync_folder
fi
