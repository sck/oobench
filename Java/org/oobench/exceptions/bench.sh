#! /bin/sh
./run.sh org.oobench.exceptions.WithoutExceptionsPerformance ${1+"$@"}
./run.sh org.oobench.exceptions.ExceptionsPerformance ${1+"$@"}
