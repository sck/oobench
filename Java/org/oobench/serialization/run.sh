#! /bin/sh
PROJECT_ROOT=../../..
. $PROJECT_ROOT/org/oobench/common/config.sh

command="$JAVA13 $JVM_PERF_FLAGS -cp $PROJECT_ROOT ${1+$@}"
echo "% $command"
eval $command
