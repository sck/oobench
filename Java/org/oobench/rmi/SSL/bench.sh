#! /bin/sh
PROJECT_ROOT=../../../..
. $PROJECT_ROOT/org/oobench/common/config.sh

echo "*** generating keystore"
command='$KEYTOOL12 -genkey -v -alias ootest -dname "cn=RMIBench, ou=Java, o=OO Bench, c=US" -validity 365 -keypass secret -keystore .tmp.keystore -storepass secret'
echo "% $command"
$KEYTOOL12 -genkey -v -alias ootest -dname "cn=RMIBench, ou=Java, o=OO Bench, c=US" -validity 365 -keypass secret -keystore .tmp.keystore -storepass secret 2>&1

echo "*** exporting self signed certificate"
command="$KEYTOOL12 -export -keystore .tmp.keystore -storepass secret -file .tmp.clientimport.cer -alias ootest"
echo "% $command"
$command 2>&1

echo "*** starting registry"
command="$RMIREGISTRY13 -J-cp -J$PROJECT_ROOT \
-J-Djava.security.policy=ssl.policy"
echo "% $command"
$command &
PID_REGISTRY=$!
trap 'echo "*** shutting down"; kill $PID_REGISTERIT $PID_REGISTRY' 2
sleep 3

echo "*** registering SSLServer"
command="$JAVA13 $JVM_PERF_FLAGS -cp $PROJECT_ROOT -Djava.security.policy=ssl.policy \
org.oobench.rmi.ssl.RegisterSSLServer"
echo "% $command"
$command &
PID_REGISTERIT=$!
echo "*** Waiting 120 seconds for RegisterSSLServer to register SSLServer..."
sleep 120

echo "*** running benchmark"
command="$JAVA13 $JVM_PERF_FLAGS -cp $PROJECT_ROOT -Djava.security.policy=ssl.policy \
-Djavax.net.ssl.trustStore=.tmp.keystore \
org.oobench.rmi.ssl.RMIOverSSLPerformance ${1+$@}"
echo "% $command"
$command ${1+"$@"}

echo "*** Shutting down"
kill $PID_REGISTERIT $PID_REGISTRY
rm -f .tmp.*
