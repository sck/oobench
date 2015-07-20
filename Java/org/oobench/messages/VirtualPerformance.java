package org.oobench.messages;

import java.util.*;

public class VirtualPerformance extends MessagesBenchmark {

    public void myVirtualMethod() {
        int foo = 10;
        foo = foo;
    }

    public void invoke(int count) {
        reset();
        for (int i = 0; i < count; i++) {
            myVirtualMethod();
        }
        reset();
    }

    public static void main(String[] args) {
        showLocation();
        testMessages(VirtualPerformance.class, 500000000, "virtual", args);
    }
}
