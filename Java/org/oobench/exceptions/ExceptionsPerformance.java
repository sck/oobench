package org.oobench.exceptions;

import java.util.*;

public class ExceptionsPerformance extends ExceptionsBenchmark {

    public int getMinorNumber() {
        return 2;
    }

    public static void simpleException() throws Exception {
        throw new Exception();
    }

    public static void deepException2() 
            throws IllegalArgumentException, IllegalAccessException {
        throw new IllegalAccessException();
    }

    public static void deepException() {
        try {
            deepException2();
        } catch (IllegalArgumentException iae) { 
        } catch (IllegalAccessException iae) {
        }
    }

    public void except(int count) {
        reset();
        for (int i = 0; i < count; i++) {
            proceed();
            try {
                simpleException();
            } catch (Exception e) {}
        }
        reset();
    }

    public void exceptDeep(int count) {
        reset();
        for (int i = 0; i < count; i++) {
            proceed();
            try {
                deepException();
            } catch (Exception e) {}
        }
        reset();
    }

    public static void main(String[] args) {
        showLocation();
        testExceptions(ExceptionsPerformance.class, 500000, "exceptions", 
                args);
    }
}
