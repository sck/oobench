package org.oobench.io;

import java.io.*;
import org.oobench.common.*;

public class BufferedPerformanceLarge extends IOBenchmark {

    public int getMinorNumber() {
        return 2;
    }

    public void write(int count) {
        reset();
        try {
            FileOutputStream fout = new FileOutputStream(".tmp.buffer");
            BufferedOutputStream out = new BufferedOutputStream(fout);
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
            FileInputStream fin = new FileInputStream(".tmp.buffer");
            BufferedInputStream in = new BufferedInputStream(fin);
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
            FileOutputStream fout = new FileOutputStream(".tmp.buffer");
            BufferedOutputStream out = new BufferedOutputStream(fout);
            byte[] buffer = new byte[256];
            for (int i = 0; i < count / 2; i++) {
                out.write(buffer, 0, 256);
                proceed();
            }
            out.close();

            FileInputStream fin = new FileInputStream(".tmp.buffer");
            BufferedInputStream in = new BufferedInputStream(fin);
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
        testIO(BufferedPerformanceLarge.class, 50000, "buffered", args);
    }
}
