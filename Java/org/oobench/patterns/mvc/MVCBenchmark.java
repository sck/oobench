package org.oobench.patterns.mvc;

import org.oobench.common.*;
import org.oobench.patterns.mvc.common.*;

public abstract class MVCBenchmark extends AbstractBenchmark {

    public int getMajorNumber() {
        return 8;
    }

    public int getMinorNumber() {
        return 1;
    }

    public abstract void create();
    public abstract void change(int items);
    public abstract void check(int items);
    public abstract void remove(int items);

    public void test(int items) {
        items = getCountWithDefault(items);
        System.out.println("*** Benchmarking MVC");

        for (int c = 0; c < 10; c++) {
            if (c == 9) {
                beginAction(1, "creating views", 200);
            }
            create();
            if (c == 9) {
                endAction();
                beginAction(2, "change", items);
            }
            change(items);
            if (c == 9) {
                endAction();
                beginAction(3, "checking views", 200);
            }
            check(items);
            if (c == 9) {
                endAction();
                beginAction(4, "remove", items);
            }
            remove(items);
            if (c == 9) {
                endAction();
            }
        }
    }

    public static void testMVC(Class theClass, int count,
            String[] args) {
        try {
            MVCBenchmark bench = 
                    (MVCBenchmark)theClass.newInstance();
            bench.setArguments(args);
            bench.test(count);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
    }
}
