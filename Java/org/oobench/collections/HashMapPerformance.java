package org.oobench.collections;

import java.util.*;

public class HashMapPerformance extends MapBenchmark {

    public static void main(String[] args) {
        showLocation();
        testCollectionClass(HashMap.class, args, 3);
    }
}
