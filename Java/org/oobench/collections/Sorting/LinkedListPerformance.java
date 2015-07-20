package org.oobench.collections.sorting;

import java.util.*;

public class LinkedListPerformance extends CollectionBenchmark {

    public static void main(String[] args) {
        showLocation();
        testCollectionClass(LinkedList.class, args, 3);
    }
}
