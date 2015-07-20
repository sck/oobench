#! /bin/sh
PROJECT_ROOT=../..
. $PROJECT_ROOT/common/config.sh

./NSArrayPerformance.bin ${1+"$@"}
./NSDictionaryPerformance.bin ${1+"$@"}
./NSSetPerformance.bin ${1+"$@"}

