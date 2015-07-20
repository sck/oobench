package org.oobench.numerics;

import org.oobench.common.*;

public abstract class NumericsBenchmark extends AbstractBenchmark {

    public int getMajorNumber() {
        return 15;
    }

    public abstract void algorithm(int count);

    public void test(int count, String description) {
        count = getCountWithDefault(count);
        System.out.println("*** Testing " + description);

        algorithm(count);
    }

    public static void testNumerics(Class theClass, int count, 
            String description, String[] args) {
        try {
            NumericsBenchmark bench = 
                    (NumericsBenchmark)theClass.newInstance();
            bench.setArguments(args);
            bench.test(count, description);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

