package org.oobench.io;

import java.io.*;

public class SynchronizedPerformanceSmall extends IOBenchmark {

    public int getMinorNumber() {
        return 1;
    }

    public void write(int count) {
        reset();
        try {
            byte[] buffer = new byte[256];
            for (int i = 0; i < count; i++) {
                FileOutputStream out = new FileOutputStream(".tmp.buffer");
                out.write(buffer, 0, 256);
                out.close();
                proceed();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        reset();
    }

    public void read(int count) {
        reset();
        try {
            byte[] buffer = new byte[256];
            for (int i = 0; i < count; i++) {
                FileInputStream in = new FileInputStream(".tmp.buffer");
                in.read(buffer);
                in.close();
                proceed();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        reset();
    }

    public void writeAndRead(int count) {
        reset();
        try {
            byte[] buffer = new byte[256];
            for (int i = 0; i < count; i++) {
                FileOutputStream out = new FileOutputStream(".tmp.buffer");
                out.write(buffer, 0, 256);
                out.close();
                FileInputStream in = new FileInputStream(".tmp.buffer");
                in.read(buffer);
                in.close();
                proceed();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        reset();
    }

    public static void main(String[] args) {
        showLocation();
        testIO(SynchronizedPerformanceSmall.class, 50000, "synchronized", args);
    }
}
