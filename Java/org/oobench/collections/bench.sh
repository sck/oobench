echo "*** running HashSetPerformance"
./run.sh org.oobench.collections.HashSetPerformance ${1+"$@"}

echo "*** running TreeSetPerformance"
./run.sh org.oobench.collections.TreeSetPerformance ${1+"$@"}

echo "*** running VectorPerformance"
./run.sh org.oobench.collections.VectorPerformance ${1+"$@"}

echo "*** running ArrayListPerformance"
./run.sh org.oobench.collections.ArrayListPerformance ${1+"$@"}

echo "*** running LinkedListPerformance"
./run.sh org.oobench.collections.LinkedListPerformance ${1+"$@"}

echo "*** running TreeMapPerformance"
./run.sh org.oobench.collections.TreeMapPerformance ${1+"$@"}

echo "*** running HashMapPerformance"
./run.sh org.oobench.collections.HashMapPerformance ${1+"$@"}
