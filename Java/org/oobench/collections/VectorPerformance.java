package org.oobench.collections;

import java.util.*;

public class VectorPerformance extends CollectionBenchmark {

    public static void main(String[] args) {
        showLocation();
        testCollectionClass(Vector.class, args, 1, 
                "implemented using a List", "implemented using a List", 
                true);
    }
}
