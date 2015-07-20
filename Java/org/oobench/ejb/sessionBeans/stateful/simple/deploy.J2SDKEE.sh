#! /bin/sh

APPNAME=SimpleBench
#
# Configuration ends here.
#

PROJECT_ROOT=../../../../../..
. $PROJECT_ROOT/org/oobench/common/config.sh

JAR=`pwd`/$APPNAME.ear
$J2SDKEE_ROOT/bin/deploytool -deploy $JAR localhost

CLIENTJAR=${APPNAME}Client.jar
echo "*** Copying $CLIENTJAR from EAS."
cp $J2SDKEE_ROOT/repository/`hostname`/applications/$CLIENTJAR .

rm -f ejb_temp*.jar
