#! /bin/sh
PROJECT_ROOT=../../..
. $PROJECT_ROOT/org/oobench/common/config.sh


classPathAdd=".tmp" ./run.sh \
        -Doobench.classloading.minorNumber=1 \
        -Doobench.classloading.description="normal" \
        -Doobench.classloading.comment="" \
        org.oobench.classloading.ClassLoadingPerformance \
        ${1+"$@"}

classPathAdd=".tmp" flagsAdd="-noverify" ./run.sh \
        -Doobench.classloading.minorNumber=1 \
        -Doobench.classloading.description="normal" \
        -Doobench.classloading.comment="no verify" \
        org.oobench.classloading.ClassLoadingPerformance \
        ${1+"$@"}

echo "*** putting classes into .tmp.jar"
(cd .tmp; $JAR13 cf ../.tmp.jar .)
classPathAdd=".tmp.jar" ./run.sh \
        -Doobench.classloading.minorNumber=2 \
        -Doobench.classloading.description="jar" \
        -Doobench.classloading.comment="" \
        org.oobench.classloading.ClassLoadingPerformance \
        ${1+"$@"}

classPathAdd=".tmp.jar" flagsAdd="-noverify" ./run.sh \
        -Doobench.classloading.minorNumber=2 \
        -Doobench.classloading.description="jar" \
        -Doobench.classloading.comment="no verify" \
        org.oobench.classloading.ClassLoadingPerformance \
        ${1+"$@"}

echo "*** generating public/private keys and signing .tmp.jar"
$KEYTOOL12 -genkey -v -alias friend -dname "cn=CLBench, ou=Java, \
        o=OO Bench, c=US" -validity 10000 -keypass friend4life -keystore \
        .tmp.keystore -storepass oobench > /dev/null 2>&1

$KEYTOOL12 -genkey -v -alias stranger -dname "cn=CLBench, ou=Java, \
        o=OO Bench, c=US" -validity 10000 -keypass stranger4life -keystore \
        .tmp.keystore -storepass oobench > /dev/null 2>&1

command="$JARSIGNER12 -keystore .tmp.keystore \
        -storepass oobench -keypass \
        friend4life .tmp.jar friend  > /dev/null"
$command

classPathAdd=".tmp.jar" ./run.sh \
        -Doobench.classloading.minorNumber=3 \
        -Doobench.classloading.description="signed jar" \
        -Doobench.classloading.comment="" \
        org.oobench.classloading.ClassLoadingPerformance \
        ${1+"$@"}

classPathAdd=".tmp.jar" flagsAdd="-noverify" ./run.sh \
        -Doobench.classloading.minorNumber=3 \
        -Doobench.classloading.description="signed jar" \
        -Doobench.classloading.comment="no verify" \
        org.oobench.classloading.ClassLoadingPerformance \
        ${1+"$@"}

rm -rf .tmp*
