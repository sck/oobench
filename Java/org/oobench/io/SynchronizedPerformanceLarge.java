package org.oobench.io;

import java.io.*;

public class SynchronizedPerformanceLarge extends IOBenchmark {

    public int getMinorNumber() {
        return 2;
    }

    public void write(int count) {
        reset();
        try {
            FileOutputStream out = new FileOutputStream(".tmp.buffer");
            byte[] buffer = new byte[256];
            for (int i = 0; i < count; i++) {
                out.write(buffer, 0, 256);
                proceed();
            }
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        reset();
    }

    public void read(int count) {
        reset();
        try {
            FileInputStream in = new FileInputStream(".tmp.buffer");
            byte[] buffer = new byte[256];
            for (int i = 0; i < count; i++) {
                in.read(buffer);
                proceed();
            }
            in.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        reset();
    }

    public void writeAndRead(int count) {
        reset();
        try {
            FileOutputStream out = new FileOutputStream(".tmp.buffer");
            byte[] buffer = new byte[256];
            for (int i = 0; i < count / 2; i++) {
                out.write(buffer, 0, 256);
                proceed();
            }
            out.close();

            FileInputStream in = new FileInputStream(".tmp.buffer");
            for (int i = 0; i < count / 2; i++) {
                in.read(buffer);
                proceed();
            }
            in.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        reset();
    }

    public static void main(String[] args) {
        showLocation();
        testIO(SynchronizedPerformanceLarge.class, 50000, "synchronized", args);
    }
}
