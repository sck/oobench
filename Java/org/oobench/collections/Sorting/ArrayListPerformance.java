package org.oobench.collections.sorting;

import java.util.*;

public class ArrayListPerformance extends CollectionBenchmark {

    public static void main(String[] args) {
        showLocation();
        testCollectionClass(ArrayList.class, args, 1);
    }
}
