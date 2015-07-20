package org.oobench.collections.sorting;

import java.util.*;

public class TreeMapPerformance extends MapBenchmark {

    public static void main(String[] args) {
        showLocation();
        testCollectionClass(TreeMap.class, args, 4);
    }
}
