package org.oobench.collections.sorting;

import org.oobench.common.*;

public abstract class CollectionsBenchmark extends AbstractBenchmark {

    public int getMajorNumber() {
        return 9;
    }

    public abstract void add(Object theObject, int items);
    public abstract void sort(Object theObject);

    public void test(Object theObject, int items) {
        items = getCountWithDefault(items);
        long memoryAtStart = ObjectScale.getUsedMemory();
        System.out.println("*** Testing " + theObject.getClass());
        Stopwatch timer = new Stopwatch().start();
        System.out.print("add (" + items + "): " );
        add(theObject, items);
        timer.stop();
        System.out.println( timer.getElapsedTime() + " ms (" + 
                beautifyBytes(ObjectScale.getUsedMemory() - memoryAtStart) 
                + ")");

        System.out.print("sort (" + items + "): ");
        timer.reset().start();
        sort(theObject);
        timer.stop();
        System.out.println(timer.getElapsedTime() + " ms (" + 
                beautifyBytes(ObjectScale.getUsedMemory() - memoryAtStart) 
                + ")");
    }
}

