#! /bin/sh
PROJECT_ROOT=../../../../../..
. $PROJECT_ROOT/org/oobench/common/config.sh

JAVA=$JAVA13

echo "*** running TestClient"
command="$JAVA -cp $EJB_CLASSES:$PROJECT_ROOT:SimpleBenchClient.jar \
        -Doobench.application.server=$AS_SERVER \
        org.oobench.ejb.sessionbeans.stateful.simple.SimplePerformance"
echo "% $command"
eval $command
