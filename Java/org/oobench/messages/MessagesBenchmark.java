package org.oobench.messages;

import org.oobench.common.*;

public abstract class MessagesBenchmark extends AbstractBenchmark {

    public int getMajorNumber() {
        return 5;
    }

    public int getMinorNumber() {
        return 1;
    }

    public abstract void invoke(int count);

    public void test(int count, String typeOfMessage) {
        count = getCountWithDefault(count);

        for (int c = 0; c < 10; c++) {
            if (c == 9) {
                beginAction(1, "invoke", count, typeOfMessage);
            }
            invoke(count);
            if (c == 9) {
                endAction();
            }
        }
    }

    public static void testMessages(Class theClass, int count, 
            String typeOfMessage, String[] args) {
        try {
            MessagesBenchmark bench = 
                    (MessagesBenchmark)theClass.newInstance();
            bench.setArguments(args);
            bench.test(count, typeOfMessage);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

