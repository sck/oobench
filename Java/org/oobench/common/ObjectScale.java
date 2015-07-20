package org.oobench.common;
/*
 *  This class is from the book: "Java(TM) Platform Performance --
 *  Strategies and Tactics", by Steve Wilson and Jeff Kesselman,
 *  published by Addison-Wesley.
 */

public class ObjectScale {
    public static long sizeOf(Class theClass) {
        long size=0;
        Object[] objects = new Object[100];
        try {
            Object primer = theClass.newInstance();
            long startMemoryUse = getUsedMemory();
            for (int i=0; i < objects.length; i++) {
                objects[i] = theClass.newInstance();
            }
            long endingMemoryUse = getUsedMemory();
            float approxSize = (endingMemoryUse - startMemoryUse) / 100f;
            size = Math.round(approxSize);
        } catch (Exception e) {
            System.out.println("WARNING: couldn't instantiate " +
                    theClass);
            e.printStackTrace();
        }
        return size;
    }

    public static long getUsedMemory() {
        System.gc();
        long totalMemory = Runtime.getRuntime().totalMemory();
        System.gc();
        long freeMemory = Runtime.getRuntime().freeMemory();
        long usedMemory = totalMemory - freeMemory;
        return usedMemory;
    }

    private static void gc() {
        try {
            System.gc();
            Thread.currentThread().sleep(100);
            System.runFinalization();
            Thread.currentThread().sleep(100);
            System.gc();
            Thread.currentThread().sleep(100);
            System.runFinalization();
            Thread.currentThread().sleep(100);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        try {
            Class aClass = Class.forName(args[0]);
            System.out.println(sizeOf(aClass));
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.exit(0);
    }
}
