package org.oobench.collections;

import org.oobench.common.*;

public abstract class CollectionsBenchmark extends AbstractBenchmark {

    public int getMajorNumber() {
        return 1;
    }

    public abstract void add(Object theObject, int items);
    public abstract void iterate(Object theObject);
    public abstract void randomAccess(Object theObject);
    public abstract void remove(Object theObject);

    public String getRandomAccessComment() {
        return "";
    }

    public String getRemoveComment() {
        return "";
    }

    public String getAddComment() {
        return "";
    }

    public String getIterateComment() {
        return "";
    }

    public void test(Object theObject, int items) {
        items = getCountWithDefault(items);
        System.out.println("*** Testing " + theObject.getClass());

        for (int c = 0; c < 10; c++) {
            beginAction(1, "add", items, getAddComment(), (c != 9));
            add(theObject, items);
            endAction();
            beginAction(2, "iterate", items, getIterateComment(), (c != 9));

            iterate(theObject);
            endAction();
            beginAction(3, "random", items, getRandomAccessComment(), (c != 9));
            randomAccess(theObject);
            endAction();
            beginAction(4, "remove", items, getRemoveComment(), (c != 9));
            remove(theObject);
            endAction();
        }
    }
}
