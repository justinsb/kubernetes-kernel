#!/bin/bash -ex

wget -N http://ftpmirror.gnu.org/gnu/binutils/binutils-2.31.1.tar.gz

wget -N http://ftpmirror.gnu.org/gnu/gcc/gcc-8.2.0/gcc-8.2.0.tar.gz
wget -N http://ftpmirror.gnu.org/gnu/gmp/gmp-6.1.2.tar.bz2
wget -N http://ftpmirror.gnu.org/gnu/mpc/mpc-1.1.0.tar.gz
wget -N http://ftpmirror.gnu.org/gnu/mpfr/mpfr-4.0.1.tar.gz

sha256sum -c SUMS
