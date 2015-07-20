#! /bin/sh

APPNAME=SimpleBench
EAR=`pwd`/$APPNAME.ear
#
# Configuration ends here.
#
PROJECT_ROOT=../../../../../..
. $PROJECT_ROOT/org/oobench/common/config.sh

echo -n "Please enter Orion admin password: "
read ORION_PASSWORD
(
    cd $ORION_ROOT && 
            $JAVA12 $JVM_PERF_FLAGS -jar admin.jar omri://localhost/ admin $ORION_ROOT \
            -deploy -file $EAR -deploymentName $APPNAME
)

cp application-client.xml META-INF
