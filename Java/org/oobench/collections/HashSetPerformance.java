package org.oobench.collections;

import java.util.*;

public class HashSetPerformance extends SetBenchmark {

    public static void main(String[] args) {
        showLocation();
        {
            Collection hashSet = new HashSet(101, 0.75f);
            System.out.println("\n### Default: HashSet(101, 0.75f)");
            testSetCollectionClass(hashSet, args, 4, "", "", "");
        }
        {
            Collection hashSet = new HashSet(101, 1f);
            System.out.println("\n### HashSet(101, 1f)");
            testSetCollectionClass(hashSet, args, 4, 
                    "initial size: 101, load: 1", "", "");
        }
        {
            Collection hashSet = new HashSet(500000, 1f);
            System.out.println("\n### HashSet(500000, 0.75f)");
            testSetCollectionClass(hashSet, args, 4, 
                    "initial size: 500000, load: 0.75", "", "");
        }
        {
            Collection hashSet = new HashSet(500000, 1f);
            System.out.println("\n### HashSet(500000, 0.75f)");
            testSetCollectionClass(hashSet, args, 4, 
                    "initial size: 500000, load: 0.75", "", "");
        }
        {
            Collection hashSet = new HashSet(2, 0.1f);
            System.out.println("\n### HashSet(2, 0.1f)");
            testSetCollectionClass(hashSet, args, 4, 
                    "initial size: 2, load: 0.1", "", "");
        }
        {
            Collection hashSet = new HashSet(2, 1f);
            System.out.println("\n### HashSet(2, 1f)");
            testSetCollectionClass(hashSet, args, 4, 
                    "initial size: 2, load: 1", "", "");
        }
    }
}
