#! /bin/sh

APPNAME=SimpleBench
EAR=`pwd`/${APPNAME}.jar
#
# End of Configuration
#

PROJECT_ROOT=../../../../../..
. $PROJECT_ROOT/org/oobench/common/config.sh

echo -n "Please enter Weblogic admin password: "
read WEBLOGIC_PASSWORD

#WLSEAR=`pwd`/${APPNAME}WLS.jar

#
# Next step is not needed when deploying to WLS6.0!
#
#echo $JAVA13 $JVM_PERF_FLAGS -cp $WEBLOGIC_CLASSES -Dweblogic.home=$WEBLOGIC_ROOT \
#        weblogic.ejbc -g -keepgenerated -compiler $JAVAC13 $EAR .tmp.ejbc
#(
#    cd .tmp.ejbc
#    $EAR13 cf $WLSEAR .
#)
#$JAVA13 $JVM_PERF_FLAGS -cp $WEBLOGIC_ROOT/classes:$WEBLOGIC_CLASSES \
#        -Dweblogic.home=$WEBLOGIC_ROOT weblogic.deploy \
#        -debug -port 7001 undeploy $WEBLOGIC_PASSWORD $APPNAME 
#$JAVA13 $JVM_PERF_FLAGS -cp $WEBLOGIC_ROOT/classes:$WEBLOGIC_CLASSES \
#        -Dweblogic.home=$WEBLOGIC_ROOT weblogic.deploy \
#        -port 7001 update $WEBLOGIC_PASSWORD $APPNAME $EAR
echo $JAVA13 $JVM_PERF_FLAGS -cp $WEBLOGIC_ROOT/classes:$WEBLOGIC_CLASSES \
        -Dweblogic.home=$WEBLOGIC_ROOT weblogic.deploy \
        -port 7001 deploy $WEBLOGIC_PASSWORD $APPNAME $EAR
