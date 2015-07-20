package org.oobench.collections;

import java.util.*;

public class TreeMapPerformance extends MapBenchmark {

    public static void main(String[] args) {
        showLocation();
        testCollectionClass(TreeMap.class, args, 6);
    }
}
