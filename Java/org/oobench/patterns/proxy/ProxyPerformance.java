package org.oobench.patterns.proxy;

import org.oobench.common.*;
import org.oobench.patterns.proxy.common.*;

public class ProxyPerformance extends AbstractBenchmark {

    public int getMajorNumber() {
        return 8;
    }

    public int getMinorNumber() {
        return 2;
    }

    public void test(int count) {
        count = getCountWithDefault(count);
        System.out.println("*** Benchmarking Proxy");

        for (int c = 0; c < 10; c++) {
            if (c == 9) {
                beginAction(1, "method call", count, 
                    "needs to know methods beforehand");
            }
            DataInterface dataPointer = 
                    (DataInterface)Proxy.newInstance(new Data());
            reset();
            for (int i = 0; i < count; i++) {
                if (dataPointer.getSize() != 1234) {
                    System.err.println("Error: getSize() did not return the " + 
                            "expected value (1234)!");
                    break;
                }
            }
            reset();
            if (c == 9) {
                endAction();
                beginAction(2, "method call, without proxy", count);
            }
            DataInterface data = new Data();
            reset();
            for (int i = 0; i < count; i++) {
                if (data.getSize() != 1234) {
                    System.err.println("Error: getSize() did not return the " + 
                            "expected value (1234)!");
                    break;
                }
            }
            reset();
            if (c == 9) {
                endAction();
            }
        }
    }

    public static void main(String[] args) {
        showLocation();
        ProxyPerformance bench = new ProxyPerformance();
        bench.setArguments(args);
        bench.test(1000000);
    }
}
