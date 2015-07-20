#! /bin/sh
PROJECT_ROOT=../..
. $PROJECT_ROOT/common/config.sh

./ArchivingPerformanceSimple.bin ${1+"$@"}
./ArchivingPerformanceComplex.bin ${1+"$@"}

