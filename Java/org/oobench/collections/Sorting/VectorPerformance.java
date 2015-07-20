package org.oobench.collections.sorting;

import java.util.*;

public class VectorPerformance extends CollectionBenchmark {

    public static void main(String[] args) {
        showLocation();
        testCollectionClass(Vector.class, args, 6);
    }
}
