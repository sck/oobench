package org.oobench.corba.simple;

import org.oobench.common.AbstractBenchmark;
import org.oobench.common.Stopwatch;
import org.oobench.common.ObjectScale;

public abstract class CORBABenchmark extends AbstractBenchmark {

    public int getMajorNumber() {
        return 13;
    }

    public abstract void simple(int count);

    public void test(int count, String description) {
        count = getCountWithDefault(count);
        System.out.println("*** Testing CORBA (" + description + ")");

        for (int c = 0; c < 10; c++) {
            if (c == 9) {
                beginAction(1, "simple", count);
            }
            simple(count);
            if (c == 9) {
                endAction();
            }
        }
    }
}

