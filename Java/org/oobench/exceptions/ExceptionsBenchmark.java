package org.oobench.exceptions;

import org.oobench.common.*;

public abstract class ExceptionsBenchmark extends AbstractBenchmark {

    public int getMajorNumber() {
        return 3;
    }

    public abstract void except(int count);
    public abstract void exceptDeep(int count);

    public void test(int count, String description) {
        count = getCountWithDefault(count);
        System.out.println("*** Testing " + description);

        for (int c = 0; c < 10; c++) {
            if (c == 9) {
                beginAction(1, "except", count);
            }
            except(count);
            if (c == 9) {
                endAction();
                beginAction(2, "except deep", count);
            }
            exceptDeep(count);
            if (c == 9) {
                endAction();
            }
        }
    }

    public static void testExceptions(Class theClass, int count, 
            String description, String[] args) {
        try {
            ExceptionsBenchmark bench = 
                    (ExceptionsBenchmark)theClass.newInstance();
            bench.setArguments(args);
            bench.test(count, description);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
    }
}
