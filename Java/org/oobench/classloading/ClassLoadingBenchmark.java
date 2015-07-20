package org.oobench.classloading;

import org.oobench.common.*;

public class ClassLoadingBenchmark extends AbstractBenchmark {
    private Stopwatch timer;
    private String comment;
    private int count;

    ClassLoadingBenchmark(int theCount) {
        String description = 
                System.getProperty("oobench.classloading.description");
        String aComment = System.getProperty("oobench.classloading.comment");
        comment = description + (aComment.equals("") ? "" : ", " +
                System.getProperty("oobench.classloading.comment"));
        count = theCount;
    }

    public int getMajorNumber() {
        return 11;
    }

    public int getMinorNumber() {
        return new Integer(System.
                getProperty("oobench.classloading.minorNumber")).intValue();
    }

    public void start() {
        beginAction(1, "class loading", count, comment);
    }

    public void stop() {
        endAction();
    }
}
