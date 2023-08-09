#!/bin/bash
set -e

#git clone https://github.com/Kitware/CMake.git
#cd CMake
#./bootstrap && make -j 16 && make -j 16 install
git clone -b release/14.x https://github.com/llvm/llvm-project /usr/lib/llvmTest
cd /usr/lib/llvmTest
mkdir build
cd build
cmake -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RUNTIMES=compiler-rt -G "Unix Makefiles" ../llvm
make -j 16

apt-get update \
	&&  apt -y dist-upgrade \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y\
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
