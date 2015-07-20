#! /bin/sh
PROJECT_ROOT=../../../..
. $PROJECT_ROOT/org/oobench/common/config.sh

rm -f .tmp.*

gmake || exit 

./bench.sh ${1+"$@"}

