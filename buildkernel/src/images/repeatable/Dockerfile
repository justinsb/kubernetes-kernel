# Based on http://preshing.com/20141119/how-to-build-a-gcc-cross-compiler/
# and https://wiki.osdev.org/GCC_Cross-Compiler

#FROM ubuntu:18.04
FROM debian:jessie

COPY build.sh /
COPY dist/ /dist

RUN /build.sh
