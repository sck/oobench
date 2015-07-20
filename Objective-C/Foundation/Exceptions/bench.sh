#! /bin/sh
PROJECT_ROOT=../..
. $PROJECT_ROOT/common/config.sh

./WithoutExceptionsPerformance.bin ${1+"$@"}
./ExceptionsPerformance.bin ${1+"$@"}

