package org.oobench.threads;

import org.oobench.common.*;

public class ThreadCreationPerformance extends AbstractBenchmark 
        implements Runnable {
    int maxThreads = 0;
    int id;
    ThreadCreationPerformance parentBench = null;

    ThreadCreationPerformance() {
    }

    ThreadCreationPerformance(int theId, 
            ThreadCreationPerformance theParentBench) {
        id = theId;
        parentBench = theParentBench;
    }

    public int getMajorNumber() {
        return 6;
    }

    public int getMinorNumber() {
        return 1;
    }

     void test() {
        maxThreads = getCountWithDefault(20000);
        for (int c = 0; c < 10; c++) {
            if (c == 9) {
                beginAction(1, "thread creation", maxThreads);
            }
            reset();
            ThreadCreationPerformance performance = 
                    new ThreadCreationPerformance(1, this);
            for (int i = 0; i < maxThreads; i++) {
                Thread thread = new Thread(performance);
                thread.start();
                try {
                    thread.join();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            reset();
            if (c == 9) {
                endAction();
            }
        }
    }

    public static void main(String args[]) {
        showLocation();
        ThreadCreationPerformance bench = new ThreadCreationPerformance();
        bench.setArguments(args);
        bench.test();
    }

    public void run() {
        parentBench.proceed();
    }
}
