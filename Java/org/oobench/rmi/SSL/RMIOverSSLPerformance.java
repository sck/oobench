package org.oobench.rmi.ssl;

import org.oobench.rmi.*;

public abstract class RMIOverSSLPerformance extends RMIBenchmark {
    public static void main(String[] args) {
        showLocation();
        testRMI(50000, "simple over ssl", args, 2);
    }
}
