#!/bin/bash -ex

BASEDIR=`pwd`

CORES=`nproc`
MAKEARGS=" -j${CORES} "

apt-get update

apt-get install --yes gcc g++ make

mkdir -p /opt/cross
export PATH="/opt/cross/bin:${PATH}"

# Install make (not _really_ needed)
# Removed because segfaulting
#COPY /build-make.sh /
#RUN /build-make.sh
#RUN apt-get remove --yes make
#RUN cd /build/make/src && ./make install
#RUN make --version

# Build binutils

mkdir -p /build/binutils/src
tar zx --strip-components=1 -C /build/binutils/src -f ${BASEDIR}/dist/binutils-2.31.1.tar.gz

cd /build/binutils
rm -rf build
mkdir build
cd build
../src/configure --prefix=/opt/cross --target=amd64-linux --with-sysroot --disable-nls

make ${MAKEARGS}
make install


# Build GCC
apt-get install --yes bzip2

mkdir -p /build/gcc/src
tar zx --strip-components=1 -C /build/gcc/src -f ${BASEDIR}/dist/gcc-8.2.0.tar.gz

mkdir -p /build/gcc/gmp
tar x --strip-components=1 -C /build/gcc/gmp -f ${BASEDIR}/dist/gmp-6.1.2.tar.bz2

mkdir -p /build/gcc/mpc
tar x --strip-components=1 -C /build/gcc/mpc -f ${BASEDIR}/dist/mpc-1.1.0.tar.gz

mkdir -p /build/gcc/mpfr
tar x --strip-components=1 -C /build/gcc/mpfr -f ${BASEDIR}/dist/mpfr-4.0.1.tar.gz

cd /build/gcc
pushd src
ln -sf ../gmp
ln -sf ../mpc
ln -sf ../mpfr
popd

rm -rf build
mkdir build
cd build
../src/configure --prefix=/opt/cross --target=amd64-linux --enable-languages=c --without-headers --disable-nls --disable-multilib

make ${MAKEARGS} all-gcc
make ${MAKEARGS} all-target-libgcc
make install-gcc
make install-target-libgcc




# Install dependencies for building kernel
apt-get install --yes git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc wget gnupg2
apt-get install --yes file

# Install deps for building perf-tools
apt-get install --yes libaudit-dev libslang2-dev libelf-dev libdw-dev libnuma-dev libunwind-dev libperl-dev libiberty-dev \
     asciidoc binutils-dev flex bison \
     python-dev libgtk2.0-dev rename

