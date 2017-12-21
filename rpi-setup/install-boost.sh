#!/bin/bash

# Install boost 1.65.1
git clone https://github.com/boostorg/boost /tmp/boost

cd /tmp/boost; git checkout 436ad1dfcfc7e0246141beddd11c8a4e9c10b146
cd /tmp/boost; git submodule init
cd /tmp/boost; git submodule update --recursive

cd /tmp/boost; /tmp/boost/bootstrap.sh --with-libraries=system,filesystem
cd /tmp/boost; /tmp/boost/b2 headers
cd /tmp/boost; /tmp/boost/b2 cxxflags="-std=c++14" -j 4 install

rm -fr /tmp/boost

exit 0
