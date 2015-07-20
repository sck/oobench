package org.oobench.threads;

import org.oobench.common.*;

public class ThreadContentionPerformance extends AbstractBenchmark 
        implements Runnable {
    final static int maxThreads = 100;
    int id;
    ThreadContentionPerformance parentBench = null;

    private ThreadContentionPerformance() {
    }

    ThreadContentionPerformance(int theId, 
            ThreadContentionPerformance theParentBench) {
        id = theId;
        parentBench = theParentBench;
    }

    public int getMajorNumber() {
        return 7;
    }

    public int getMinorNumber() {
        return 1;
    }

     void test() {
        for (int c = 0; c < 10; c++) {
            if (c == 9) {
                beginAction(1, "thread contention", maxThreads);
            }
            reset();
            ThreadContentionPerformance performance = 
                    new ThreadContentionPerformance(1, this);
            for (int i = 0; i < maxThreads; i++) {
                Thread thread = new Thread(performance);
                thread.start();
                try {
                    thread.join();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            notifyAll();
            try {
                Thread.sleep(100);
            } catch (InterruptedException ie) { }
            if (c == 9) {
                endAction();
            }
        }
    }

    public static void main(String args[]) {
        showLocation();
        ThreadContentionPerformance bench = new ThreadContentionPerformance();
        bench.setArguments(args);
        bench.test();
    }

    public void run() {
        try {
            wait();
        } catch (InterruptedException ie) { 
        } 
        System.out.println(id + ": START");
        for (int i = 0; i < 9999; i++) {
            ;
        }
        System.out.println(id + ": DONE");
    }
}
