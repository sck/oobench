#! /bin/sh
PROJECT_ROOT=..
. $PROJECT_ROOT/common/config.sh

./VirtualPerformance.bin ${1+"$@"}
./StaticPerformance.bin ${1+"$@"}
