package org.oobench.rmi;

public abstract class RMIPerformance extends RMIBenchmark {

    public static void main(String[] args) {
        showLocation();
        testRMI(50000, "simple", args, 1);
    }
}
