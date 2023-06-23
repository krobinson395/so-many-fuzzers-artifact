#!/bin/sh
set -e

## Require:
#CONTIKI_PATH
#COMMIT_TO_FUZZ

## install contiki-ng
git clone https://github.com/krobinson395/contiki-ng.git ${CONTIKI_PATH}
## commit version to checkout
if [ -z "${COMMIT_TO_FUZZ}" ];
then
  git -C ${CONTIKI_PATH} pull
else
  git -C ${CONTIKI_PATH} checkout ${COMMIT_TO_FUZZ}
fi

git clone https://github.com/xzwDavid/makefile.git ${SOFTWARE_PATH}/fix_for_makefile
rm ${CONTIKI_PATH}/arch/cpu/native/Makefile.native
rm ${CONTIKI_PATH}/os/net/ipv6/uip6.c
cp ${SOFTWARE_PATH}/fix_for_makefile/Makefile.native ${CONTIKI_PATH}/arch/cpu/native/Makefile.native
cp ${SOFTWARE_PATH}/fix_for_makefile/uip6.c ${CONTIKI_PATH}/os/net/ipv6/ip6.c
