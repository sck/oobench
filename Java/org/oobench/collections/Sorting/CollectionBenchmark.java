package org.oobench.collections.sorting;

import java.io.*;
import java.util.*;
import java.lang.reflect.*;

public class CollectionBenchmark extends CollectionsBenchmark {

    private static int minorNumber;

    public int getMinorNumber() {
        return minorNumber;
    }

    public void add(Object theObject, int items) {
        Collection c = (Collection) theObject;
        reset();
        for (int i = 0; i < items; i++) {
            Integer intObject = new Integer((int)(Math.random() * 
                    items * 10000));
            c.add(intObject);
            proceed();
        }
        reset();
    }

    public void sort(Object theObject) {
        Collection c = (Collection) theObject;
        boolean implementsList = false;
        try {
            if (c instanceof List) {
                Collections.sort((List)c);
            } else {
                System.out.println("Not an instance of List!");
            }
        } catch (Exception e) { 
        }
    }

    public static void testCollectionClass(Class theClass, String[] args,
            int theMinorNumber) {
        minorNumber = theMinorNumber;
        CollectionBenchmark bench = new CollectionBenchmark();
        bench.setArguments(args);
        boolean implementsSet = false;
        try {
            Object o = theClass.newInstance();
            implementsSet = (o instanceof Set);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
        boolean implementsHashSet = false;
        try {
            Object o = theClass.newInstance();
            implementsHashSet = (o instanceof HashSet);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
        Class[] parameterTypes = { int.class, float.class };
        Constructor ctor = null;
        try {
            ctor = theClass.getConstructor(parameterTypes);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
        try {
            Collection col = (Collection) theClass.newInstance();
            System.out.println("\n###" + theClass.getName() + "()");
            bench.test(col, 50000);
            col = null;
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
    }
}
