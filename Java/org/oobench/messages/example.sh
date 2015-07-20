#! /bin/sh
PROJECT_ROOT=../../..
. $PROJECT_ROOT/org/oobench/common/config.sh

trap "true"  2
gmake clean > /dev/null

echo "*** compiling"
gmake >/dev/null

./bench.sh ${1+"$@"}

echo "*** cleaning up"
gmake clean > /dev/null
