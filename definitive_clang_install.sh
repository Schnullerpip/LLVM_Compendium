#!/bin/bash

#export LLVM_SRC_ROOT=`pwd`

LLVM_SRC_VERSION=trunk
LLVM_SRC_VERSION_REPO_DIR=trunk
# this var gets appended with LLVM_SRC_VERSION
LLVM_SRC_ROOT=~/projects/ext/src/llvm
LLVM_PROJECT_ROOT=~/projects/ext/projects/cmake/llvm
LLVM_INSTALL_ROOT=~/projects/ext/tools/llvm

mkdir LLVM_SRC_ROOT
cd LLVM_SRC_ROOT

svn co http://llvm.org/svn/llvm-project/llvm/$LLVM_SRC_VERSION_REPO_DIR $LLVM_SRC_VERSION

LLVM_SRC_ROOT=$LLVM_SRC_ROOT/$LLVM_SRC_VERSION

cd tools

svn co http://llvm.org/svn/llvm-project/cfe/$LLVM_SRC_VERSION_REPO_DIR clang

cd clang/tools

svn co http://llvm.org/svn/llvm-project/clang-tools-extra/$LLVM_SRC_VERSION_REPO_DIR extra

#TODO check:
#cd ~/projects/ext/src/llvm/$LLVM_SRC_VERSION/projects
#svn co http://llvm.org/svn/llvm-project/test-suite/$LLVM_SRC_VERSION_REPO_DIR test-suite

# In order to generate doxygen documentation (optional)
#sudo apt install graphviz doxygen

LLVM_PROJECT_ROOT=$LLVM_PROJECT_ROOT/$LLVM_SRC_VERSION
LLVM_INSTALL_ROOT=$LLVM_INSTALL_ROOT/$LLVM_SRC_VERSION

mkdir $LLVM_PROJECT_ROOT
cd $LLVM_PROJECT_ROOT

cmake -G "Ninja" \
 -DCMAKE_INSTALL_PREFIX=$LLVM_INSTALL_ROOT \
 -DCMAKE_BUILD_TYPE=Release \
#TODO check: -DLLVM_ENABLE_ASSERTIONS=ON \
# needed for LibTooling \
 -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
 -DLLVM_EXPORT_SYMBOLS_FOR_PLUGINS=ON \
 -DLLVM_BUILD_TESTS=ON \
# Builds a release tablegen that gets used during the LLVM build. This can dramatically speed up debug builds. \
# -DLLVM_OPTIMIZED_TABLEGEN=ON \
# -DCLANG_BUILD_EXAMPLES=ON \
# -DLLVM_BUILD_EXAMPLES=ON \
 $LLVM_SRC_ROOT

# needed for LibTooling
ln -f -s $LLVM_PROJECT_ROOT/compile_commands.json $LLVM_SRC_ROOT

ninja
#ninja check       # Test LLVM only.
#ninja clang-test  # Test Clang only.
ninja check-all   # Test all. (I guess?)

# build again but this time set Clang as its own compiler
# this invalidates the cmake cache and all other options need to be applied again
cmake \
 -DCMAKE_C_COMPILER=$LLVM_INSTALL_ROOT/bin/clang \
 -DCMAKE_CXX_COMPILER=$LLVM_INSTALL_ROOT/bin/clang++ \
 -DCMAKE_INSTALL_PREFIX=$LLVM_INSTALL_ROOT \
 -DCMAKE_BUILD_TYPE=Release \
#TODO check: -DLLVM_ENABLE_ASSERTIONS=ON \
# needed for LibTooling \
 -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
 -DLLVM_EXPORT_SYMBOLS_FOR_PLUGINS=ON \
 -DLLVM_BUILD_TESTS=ON \
# Builds a release tablegen that gets used during the LLVM build. This can dramatically speed up debug builds. \
# -DLLVM_OPTIMIZED_TABLEGEN=ON \
# -DCLANG_BUILD_EXAMPLES=ON \
# -DLLVM_BUILD_EXAMPLES=ON \
 $LLVM_SRC_ROOT

# to really make sure everything works
ninja check-all

ninja install

# you should add the install dir to the PATH variable
# linux: /etc/environment
