#! /bin/sh

./run.sh org.oobench.io.BufferedPerformanceLarge ${1+"$@"}
./run.sh org.oobench.io.BufferedPerformanceSmall ${1+"$@"}
./run.sh org.oobench.io.SynchronizedPerformanceLarge ${1+"$@"}
./run.sh org.oobench.io.SynchronizedPerformanceSmall ${1+"$@"}
