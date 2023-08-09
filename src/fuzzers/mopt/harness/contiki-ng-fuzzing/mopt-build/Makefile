CONTIKI_PROJECT = fuzzer-mopt
all: $(CONTIKI_PROJECT)

CONTIKI = ../../contiki-ground-truth
CLANG_CC = /usr/lib/llvmTest/build/bin/clang-14
CLANG=1
CLFLAGS+= -fprofile-instr-generate -fcoverage-mapping
LDFLAGS += -fprofile-instr-generate -fcoverage-mapping
include ../configuration/Makefile.all-modules
include $(CONTIKI)/Makefile.include
