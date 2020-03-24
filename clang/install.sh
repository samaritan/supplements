#!/bin/bash

CLANG_INSTALL_DIR=/tmp/clang-install
CLANG_BUILD_DIR=/tmp/clang-build

mkdir -p "$CLANG_INSTALL_DIR"
mkdir -p "$CLANG_BUILD_DIR/build"

pushd "$CLANG_BUILD_DIR/build"

cmake -G Ninja \
  -DLLVM_TARGETS_TO_BUILD=Native \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_ENABLE_PROJECTS=clang \
  "$CLANG_BUILD_DIR/llvm"
ninja -j 2 install # Increase number of jobs if sufficient memory is available 

popd

rm -rf "$CLANG_BUILD_DIR/build" "$CLANG_BUILD_DIR" "$CLANG_INSTALL_DIR"
