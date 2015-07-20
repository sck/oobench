#! /bin/sh
PROJECT_ROOT=../../../..
. $PROJECT_ROOT/org/oobench/common/config.sh

echo "*** Starting tnameserv"
$TNAMESERV -ORBInitialPort 2900 &
sleep 5

echo "*** Starting SimpleServer"
./run.sh org.oobench.corba.simple.SimpleServer -ORBInitialPort 2900 &
sleep 5

echo "*** Starting SimplePerformance"
./run.sh org.oobench.corba.simple.SimplePerformance ${1+"$@"} \
        -ORBInitialPort 2900 

echo "*** Killing"
rm -f *.class
killall java
killall tnameserv
