package org.oobench.collections;

import java.util.*;

public class MapBenchmark extends CollectionsBenchmark {

    private static int minorNumber;

    public int getMinorNumber() {
        return minorNumber;
    }

    public void add(Object theObject, int items) {
        Map m = (Map) theObject;
        reset();
        for (int i = 0; i < items; i++) {
            Integer intObject = new Integer((int)(Math.random() * 
                    items * 10000));
            m.put(intObject, intObject);
            proceed();
        }
        reset();
    }

    public void iterate(Object theObject) {
        Map m = (Map) theObject;
        int size = m.size();
        reset();
        Iterator iter = (m.keySet()).iterator();
        while (iter.hasNext()) {
            Object o = iter.next();
            proceed();
        }
        reset();
    }

    public void remove(Object theObject) {
        reset();
        Map m = (Map) theObject;
        m.clear();
        reset();
    }

    public void randomAccess(Object theObject) {
        Map m = (Map) theObject;
        int size = m.size();
        reset();
        for (int i = 0; i < size; i++) {
            Integer anInt = (Integer) m.get((Object)new Integer(
                    (int)(Math.random() * size)));
            proceed();
        }
        reset();
    }

    public static void testCollectionClass(Class theClass, String[] args, 
            int theMinorNumber) {
        minorNumber = theMinorNumber;
        MapBenchmark bench = new MapBenchmark();
        bench.setArguments(args);
        boolean implementsSet = false;
        try {
            Map map = (Map) theClass.newInstance();
            System.out.println("\n###" + theClass.getName() + "()");
            bench.test(map, 500000);
            map = null;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
