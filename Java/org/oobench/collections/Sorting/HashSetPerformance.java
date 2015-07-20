package org.oobench.collections.sorting;

import java.util.*;

public class HashSetPerformance extends CollectionBenchmark {

    public static void main(String[] args) {
        showLocation();
        testCollectionClass(HashSet.class, args, 6);
    }
}
