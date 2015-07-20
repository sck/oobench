echo "*** running HashSetPerformance"
./run.sh org.oobench.collections.sorting.HashSetPerformance ${1+"$@"}

echo "*** running TreeSetPerformance"
./run.sh org.oobench.collections.sorting.TreeSetPerformance ${1+"$@"}

echo "*** running VectorPerformance"
./run.sh org.oobench.collections.sorting.VectorPerformance ${1+"$@"}

echo "*** running ArrayListPerformance"
./run.sh org.oobench.collections.sorting.ArrayListPerformance ${1+"$@"}

echo "*** running LinkedListPerformance"
./run.sh org.oobench.collections.sorting.LinkedListPerformance ${1+"$@"}

echo "*** running TreeMapPerformance"
./run.sh org.oobench.collections.sorting.TreeMapPerformance ${1+"$@"}

echo "*** running HashMapPerformance"
./run.sh org.oobench.collections.sorting.HashMapPerformance ${1+"$@"}
