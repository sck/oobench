package org.oobench.collections;

import java.util.*;

public class TreeSetPerformance extends SetBenchmark {

    public static void main(String[] args) {
        showLocation();
        System.out.println("\n###" + "TreeSet()");
        testSetCollectionClass(new TreeSet(), args, 7, "", "", "");
    }
}
