package org.oobench.numerics;

import java.util.*;

public class GaussPerformance extends NumericsBenchmark {

    public int getMinorNumber() {
        return 1;
    }

    float gaussianRandBoxMullerSingle(int mu, int sigma) {
        float x;
        float y;
        float r2;

        do {
            x = -1f + (2.0f * (float)Math.random());
            y = -1f + (2.0f * (float)Math.random());
            r2 = x * x + y * y;
        } while (r2 > 1.0f || r2 == 0.0f);

        float n = mu + sigma * y * (float)Math.sqrt(-2.0f * 
                (float)Math.log(r2) / r2);
        return n;
    }

    double gaussianRandBoxMullerDouble(int mu, int sigma) {
        double x;
        double y;
        double r2;

        do {
            x = -1 + (2.0 * Math.random());
            y = -1 + (2.0 * Math.random());
            r2 = x * x + y * y;
        } while (r2 > 1.0 || r2 == 0.0);

        double n = mu + sigma * y * Math.sqrt(-2.0 * Math.log(r2) / r2);
        return n;
    }

    public void algorithm(int count) {
        for (int c = 0; c < 10; c++) {
            if (c == 9) {
                beginAction(1, "gauss", count, "single precision");
            }
            for (int i = 0; i < count; ++i) {
                float n = gaussianRandBoxMullerSingle(3, 6);
                n = n;
            }
            if (c == 9) {
                endAction();
            }
        }

        for (int c = 0; c < 10; c++) {
            if (c == 9) {
                beginAction(1, "gauss", count, "double precision");
            }
            for (int i = 0; i < count; ++i) {
                double n = gaussianRandBoxMullerDouble(3, 6);
                n = n;
            }
            if (c == 9) {
                endAction();
            }
        }
    }

    public static void main(String[] args) {
        showLocation();
        testNumerics(GaussPerformance.class, 5000000, "Gauss", args);
    }
}
