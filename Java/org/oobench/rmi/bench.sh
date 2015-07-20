#! /bin/sh
PROJECT_ROOT=../../..
. $PROJECT_ROOT/org/oobench/common/config.sh

echo "*** starting registry"
command="$RMIREGISTRY12 -J-cp -J$PROJECT_ROOT \
        -J-Djava.security.policy=Server.policy"
echo "% $command"
$command &
PID_REGISTRY=$!

trap 'echo "*** shutting down"; kill $PID_REGISTERIT $PID_REGISTRY' 2

sleep 3

echo "*** registering Server"
command="$JAVA12 $JVM_PERF_FLAGS -cp $PROJECT_ROOT org.oobench.rmi.RegisterServer"
echo "% $command"
$command &
PID_REGISTERIT=$!
sleep 2

echo "*** running benchmark"
command="$JAVA12 $JVM_PERF_FLAGS -cp $PROJECT_ROOT -Djava.security.policy=Server.policy \
        org.oobench.rmi.RMIPerformance ${1+$@}"
echo "% $command"
$command 

echo "*** shutting down"
kill $PID_REGISTERIT $PID_REGISTRY
