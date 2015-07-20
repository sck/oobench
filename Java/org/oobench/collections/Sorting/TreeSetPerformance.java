package org.oobench.collections.sorting;

import java.util.*;

public class TreeSetPerformance extends CollectionBenchmark {
    
    public static void main(String[] args) {
        showLocation();
        testCollectionClass(TreeSet.class, args, 5);
    }
}
