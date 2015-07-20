package org.oobench.datafiles.common;

import org.oobench.common.AbstractBenchmark;
import org.oobench.common.Stopwatch;
import org.oobench.common.ObjectScale;

public abstract class DataFilesBenchmark extends AbstractBenchmark {
    public abstract void writeAndRead(int count);

    public void test(int count, String typeOfDataFile) {
        count = getCountWithDefault(count);
        long memoryAtStart = ObjectScale.getUsedMemory();
        System.out.println("*** Testing data files (" + typeOfDataFile + ")");
        Stopwatch timer = new Stopwatch();

        timer.start();
        System.out.print("writeAndRead (" + count + "): " );
        writeAndRead(count);
        timer.stop();
        System.out.println(timer.getElapsedTime() + " ms (" + 
                beautifyBytes(ObjectScale.getUsedMemory() - memoryAtStart) 
                + ")");
    }

    public static void testDataFiles(Class theClass, int count, 
            String typeOfDataFile, String[] args) {
        try {
            DataFilesBenchmark bench =
                    (DataFilesBenchmark)theClass.newInstance();
            bench.setArguments(args);
            bench.test(count, typeOfDataFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
