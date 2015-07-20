package org.oobench.messages;

import java.util.*;

public class StaticFinalPerformance extends MessagesBenchmark {

    public static final void myStaticFinalMethod() {
        int foo = 10;
        foo = foo;
    }

    public void invoke(int count) {
        reset();
        for (int i = 0; i < count; i++) {
            myStaticFinalMethod();
        }
        reset();
    }

    public static void main(String[] args) {
        showLocation();
        testMessages(StaticFinalPerformance.class, 500000000, 
                "static final", args);
    }
}
