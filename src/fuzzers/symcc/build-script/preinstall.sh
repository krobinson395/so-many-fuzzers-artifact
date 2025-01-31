#!/bin/bash
set -e

apt-get update \
    && apt -y dist-upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        clang \
	cargo \
	g++ \
	libz3-dev \
	llvm-10-dev \
        llvm-10-tools \
	libllvm10 \
        libc++-10-dev \
        ninja-build \
        zlib1g \
        zlib1g-dev
git clone -b release/14.x https://github.com/llvm/llvm-project /usr/lib/llvmTest
cd /usr/lib/llvmTest
mkdir build
cd build
cmake -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RUNTIMES=compiler-rt -G "Unix Makefiles" ../llvm
make -j 16
#cp ./bin/clang-14 /usr/bin/clang-14
#cd ../..
#cp -r llvmTest /usr/local/sbin
# Set default clang/llvm suite (from magma)
update-alternatives \
  --install /usr/lib/llvm              llvm             /usr/lib/llvm-10  20 \
  --slave   /usr/bin/llvm-config       llvm-config      /usr/bin/llvm-config-10  \
  --slave   /usr/bin/llvm-ar           llvm-ar          /usr/bin/llvm-ar-10 \
  --slave   /usr/bin/llvm-as           llvm-as          /usr/bin/llvm-as-10 \
  --slave   /usr/bin/llvm-bcanalyzer   llvm-bcanalyzer  /usr/bin/llvm-bcanalyzer-10 \
  --slave   /usr/bin/llvm-c-test       llvm-c-test      /usr/bin/llvm-c-test-10 \
  --slave   /usr/bin/llvm-cov          llvm-cov         /usr/bin/llvm-cov-10 \
  --slave   /usr/bin/llvm-diff         llvm-diff        /usr/bin/llvm-diff-10 \
  --slave   /usr/bin/llvm-dis          llvm-dis         /usr/bin/llvm-dis-10 \
  --slave   /usr/bin/llvm-dwarfdump    llvm-dwarfdump   /usr/bin/llvm-dwarfdump-10 \
  --slave   /usr/bin/llvm-extract      llvm-extract     /usr/bin/llvm-extract-10 \
  --slave   /usr/bin/llvm-link         llvm-link        /usr/bin/llvm-link-10 \
  --slave   /usr/bin/llvm-mc           llvm-mc          /usr/bin/llvm-mc-10 \
  --slave   /usr/bin/llvm-nm           llvm-nm          /usr/bin/llvm-nm-10 \
  --slave   /usr/bin/llvm-objdump      llvm-objdump     /usr/bin/llvm-objdump-10 \
  --slave   /usr/bin/llvm-ranlib       llvm-ranlib      /usr/bin/llvm-ranlib-10 \
  --slave   /usr/bin/llvm-readobj      llvm-readobj     /usr/bin/llvm-readobj-10 \
  --slave   /usr/bin/llvm-rtdyld       llvm-rtdyld      /usr/bin/llvm-rtdyld-10 \
  --slave   /usr/bin/llvm-size         llvm-size        /usr/bin/llvm-size-10 \
  --slave   /usr/bin/llvm-stress       llvm-stress      /usr/bin/llvm-stress-10 \
  --slave   /usr/bin/llvm-symbolizer   llvm-symbolizer  /usr/bin/llvm-symbolizer-10 \
  --slave   /usr/bin/llvm-tblgen       llvm-tblgen      /usr/bin/llvm-tblgen-10

update-alternatives \
  --install /usr/bin/clang             clang            /usr/bin/clang-10 20\
  --slave   /usr/bin/clang++           clang++          /usr/bin/clang++-10 \
  --slave   /usr/bin/clang-cpp         clang-cpp        /usr/bin/clang-cpp-10

