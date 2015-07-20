#! /bin/sh
PROJECT_ROOT=../../..
. $PROJECT_ROOT/org/oobench/common/config.sh

command="$JAVA12 $JVM_PERF_FLAGS -cp ../../..:$classPathAdd"
eval $command ${1+"$@"}
