package org.oobench.io;

import java.io.*;

public class BufferedPerformanceSmall extends IOBenchmark {

    public int getMinorNumber() {
        return 1;
    }

    public void write(int count) {
        reset();
        try {
            byte[] buffer = new byte[256];
            for (int i = 0; i < count; i++) {
                FileOutputStream fout = new FileOutputStream(".tmp.buffer");
                BufferedOutputStream out = 
                        new BufferedOutputStream(fout);
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
                FileInputStream fin = new FileInputStream(".tmp.buffer");
                BufferedInputStream in = 
                        new BufferedInputStream(fin);
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
                FileOutputStream fout = new FileOutputStream(".tmp.buffer");
                BufferedOutputStream out = 
                        new BufferedOutputStream(fout);
                out.write(buffer, 0, 256);
                out.close();
                FileInputStream fin = new FileInputStream(".tmp.buffer");
                BufferedInputStream in = 
                        new BufferedInputStream(fin);
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
        testIO(BufferedPerformanceSmall.class, 50000, "buffered", args);
    }
}
