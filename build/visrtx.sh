#! /bin/bash

set -e

build_pkgs \
	build-essential \
	pkg-config	\
	curl		\
	cmake		\
	cmake-curses-gui\
	nvidia-cuda-toolkit \
        ninja-build     \

runtime_pkgs \
	libstdc++6	\
	zlib1g

BUILD_DIR=/root/visrtx-build

# get source
mkdir -p $BUILD_DIR

curl -kL https://github.com/NVIDIA/VisRTX/archive/v0.1.6.tar.gz \
    | tar zx -C $BUILD_DIR --strip-components 1

# configure and build
pushd $BUILD_DIR

cmake -G Ninja \
      -DCMAKE_INSTALL_PREFIX=/usr       \
      -DCMAKE_BUILD_TYPE=MinSizeRel        \
      -DBUILD_EXAMPLES=OFF              \
      ..

exit 0

ninja -C build install

popd

rm -rf $BUILD_DIR
