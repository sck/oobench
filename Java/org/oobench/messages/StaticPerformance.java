package org.oobench.messages;

import java.util.*;

public class StaticPerformance extends MessagesBenchmark {

    public static void myStaticMethod() {
        int foo = 10;
        foo = foo;
    }

    public void invoke(int count) {
        reset();
        for (int i = 0; i < count; i++) {
            myStaticMethod();
        }
        reset();
    }

    public static void main(String[] args) {
        showLocation();
        testMessages(StaticPerformance.class, 500000000, "static", args);
    }
}
