#! /bin/sh
PROJECT_ROOT=../../../../..
. $PROJECT_ROOT/org/oobench/common/config.sh

$JAVA13 $JVM_PERF_FLAGS -cp ../../../../.. \
     org.oobench.ejb.common.deploy.FileUtilsTest
