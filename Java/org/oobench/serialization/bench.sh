#! /bin/sh

echo "*** running SerializationPerformanceSimpleVersioned"
./run.sh org.oobench.serialization.SerializationPerformanceSimpleVersioned \
        ${1+"$@"}

echo "*** running SerializationPerformanceSimple"
./run.sh org.oobench.serialization.SerializationPerformanceSimple ${1+"$@"}

echo "*** running SerializationPerformanceComplexVersioned"
./run.sh org.oobench.serialization.SerializationPerformanceComplexVersioned \
        ${1+"$@"}

echo "*** running SerializationPerformanceComplex"
./run.sh org.oobench.serialization.SerializationPerformanceComplex ${1+"$@"}

