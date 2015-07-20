#! /bin/sh

./run.sh org.oobench.messages.StaticPerformance ${1+"$@"}
./run.sh org.oobench.messages.VirtualPerformance ${1+"$@"}
./run.sh org.oobench.messages.StaticFinalPerformance ${1+"$@"}

