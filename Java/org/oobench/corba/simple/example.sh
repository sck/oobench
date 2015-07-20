#! /bin/sh
PROJECT_ROOT=../../../..
. $PROJECT_ROOT/org/oobench/common/config.sh

rm -f *.class
IDLJ=/usr/local/linux-jdk1.3.0/bin/idlj
TNAMESERV=/usr/local/linux-jdk1.3.0/bin/tnameserv

echo "*** Generating IDL skeleton from Simple.idl"
$IDLJ -pkgPrefix Simple org.oobench.corba.simple \
        -td ../../../.. -fall Simple.idl

echo "*** Compiling classes"
gmake 

./bench.sh ${1+"$@"}

