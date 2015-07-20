package org.oobench.collections;

import java.io.*;
import java.util.*;
import java.lang.reflect.*;

public class CollectionBenchmark extends CollectionsBenchmark {

    private static int minorNumber;
    protected static boolean wantSmallScaleForRandomAccess = true;
    protected static boolean wantSmallScaleForRemove = false;

    private static String randomAccessComment = "";
    private static String removeComment = "";
    private static String generalComment = "";

    public String getRandomAccessComment() {
        return (generalComment.equals("") ? randomAccessComment : 
                generalComment);
    }

    public static void setRandomAccessComment(String newComment) {
        randomAccessComment = newComment;
    }

    public String getRemoveComment() {
        return (generalComment.equals("") ? removeComment : 
                generalComment);
    }

    public static void setRemoveComment(String newComment) {
        removeComment = newComment;
    }

    public String getIterateComment() {
        return generalComment;
    }

    public static void setGeneralComment(String newComment) {
       generalComment = newComment;
    }

    public String getAddComment() {
        return generalComment;
    }

    public int getMinorNumber() {
        return minorNumber;
    }

    public static void setMinorNumber(int aMinorNumber) {
        minorNumber = aMinorNumber;
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

    public void iterate(Object theObject) {
        Collection c = (Collection) theObject;
        int size = c.size();
        reset();
        Iterator iter = c.iterator();
        while (iter.hasNext()) {
            Object o = iter.next();
            proceed();
        }
        reset();
    }

    public void remove(Object theObject) {
        reset();
        Collection c = (Collection) theObject;
        c.clear();
        reset();
    }

    public void randomAccess(Object theObject) {
        Collection c = (Collection) theObject;
        int size = c.size();
        reset();
        if (wantSmallScaleForRandomAccess) {
            for (int i = 0; i < size; i++) {
                boolean b = c.contains(new Integer(
                        (int)(Math.random() * size)));
                size = proceedSmallScaleAllowed(size);
            }
        } else {
            for (int i = 0; i < size; i++) {
                boolean b = c.contains(new Integer(
                        (int)(Math.random() * size)));
                proceed();
            }
        }
        reset();
    }

    public static void testCollectionClass(Class theClass, String[] args, 
            int theMinorNumber) {
        testCollectionClass(theClass, args, theMinorNumber, "", "", false);
    }

    public static void testCollectionClass(Class theClass, String[] args, 
            int theMinorNumber, String aRandomAccessComment, 
            String aRemoveComment, boolean smallScaleForRemove) {
        randomAccessComment = aRandomAccessComment;
        removeComment = aRemoveComment;
        minorNumber = theMinorNumber;
        CollectionBenchmark bench = new CollectionBenchmark();
        bench.setArguments(args);
        wantSmallScaleForRemove = smallScaleForRemove;
        try {
            Collection col = (Collection) theClass.newInstance();
            System.out.println("\n###" + theClass.getName() + "()");
            bench.test(col, 500000);
            col = null;
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
    }
}
