package org.oobench.common;

import java.util.*;
import java.text.*;
import java.io.*;

public abstract class AbstractBenchmark {
    private int internalCount = 0;
    private int refreshCounter = 0;
    private int watermark = 0;

    private static final String BACK =
        "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b";
    private static final String SPACE =
        "                    ";

    private long then;

    private boolean verify = false;
    private boolean slow;
    private boolean accurate = true;
    private boolean testOnly = false;
    private boolean warmup = false;
    Stopwatch timer = new Stopwatch();
    private long memoryAtBegin;
    private boolean smallScale;
    private DecimalFormat decimalFormat;

    Collection arguments = new ArrayList();

    public AbstractBenchmark() {
        Locale.setDefault(Locale.US);
        decimalFormat = new DecimalFormat("####.##");
        decimalFormat.setMinimumFractionDigits(2);
        decimalFormat.setMaximumFractionDigits(2);
    }

    public void setArguments(String args[]) {
        for (int i = 0; i < args.length; i++) {
            arguments.add(args[i]);
        }

        accurate = !arguments.contains("-p");
        if (!accurate) {
            System.out.println("Play mode, don't take results too serious.");
        }
        testOnly = arguments.contains("-t");
        if (testOnly) {
            System.out.println("Tests only.");
        }
    }

    public abstract int getMajorNumber();
    public abstract int getMinorNumber();

    public boolean isTestOnly() {
        return testOnly;
    }

    public void reset() {
        slow = !accurate;
        if (accurate) {
            return;
        }
        if (internalCount > 0) {
            String s = new Integer(internalCount).toString();
            System.out.print(SPACE.substring(0, s.length() + 1) +
                    BACK.substring(0, s.length() + 1));
        }
        internalCount = 0;
        refreshCounter = 0;
        then = System.currentTimeMillis();
        watermark = 99;
    }

    private int _proceed(boolean smallScaleAllowed, int size) {
        if (accurate) {
            if (smallScaleAllowed && !smallScale) {
                smallScale = true;
                return size / 5000;
            }
            return size;
        }
        internalCount++;
        refreshCounter++;
        long now = then;
        if (slow) {
            now = System.currentTimeMillis();
            if (now - then < 5) {
                slow = false;
                watermark = 9999;
            }
        } 

        if (slow || refreshCounter > watermark) {
            refreshCounter = 0;
            then = now;
            String s = new Integer(internalCount).toString() + 
                (slow ? "s" : "f");
            System.out.print(s);
            System.out.print(BACK.substring(0, s.length()));
        }
        if (smallScaleAllowed && !smallScale && slow) {
            smallScale = true;
            return size / 5000;
        }
        return size;
    }

    public void proceed() {
        _proceed(false, 0);
    }

    public int proceedSmallScaleAllowed(int size) {
        return _proceed(true, size);
    }

    public static void showLocation() {
        StringWriter sw = new StringWriter();
        new Throwable().printStackTrace(new PrintWriter(sw));
        StringTokenizer st = new StringTokenizer(sw.toString(), "\n");
        st.nextToken();
        st.nextToken();
        // ^ at org.oobench.exceptions.ExceptionsPerformance.main(ExceptionsPerformance.java:51)$
        String rawLocation = (String)st.nextToken();
        String locationPre = rawLocation.substring(
                rawLocation.indexOf("at ") + 3, 
                rawLocation.lastIndexOf('('));
        locationPre = locationPre.substring(0,
                locationPre.lastIndexOf('.')).replace('.', '/');
        String location = "Java/" + locationPre + ".java";
        System.out.println("Location: " + location);
    }

    public void beginAction(int subNumber, String message, int count,
            String comment, boolean warmupFlag) {
        memoryAtBegin = ObjectScale.getUsedMemory();
        warmup = warmupFlag;
        if (!warmup) {
            System.out.print("Java: [" + getMajorNumber() + "." +
                    getMinorNumber() + "." + subNumber + "] " +
                    message + " (" + count + ")");
            if (!comment.equals("")) {
                System.out.print(" -- " + comment);
            }
            System.out.print(": ");
        }
        timer.reset().start();
        smallScale = false;
    }

    public void beginAction(int subNumber, String message, int count,
            String comment) {
        beginAction(subNumber, message, count, comment, false);
    }

    public void beginAction(int subNumber, String message, int count) {
        beginAction(subNumber, message, count, "");
    }

    public void endAction() {
        timer.stop();
        if (!warmup) {
            if (smallScale) {
                System.out.println( timer.getElapsedTime() * 5000 + "e ms (" + 
                        beautifyBytes(ObjectScale.getUsedMemory() - 
                        memoryAtBegin) + "+?)");
            } else {
                System.out.println( timer.getElapsedTime() + " ms (" + 
                        beautifyBytes(ObjectScale.getUsedMemory() - 
                        memoryAtBegin) + ")");
            }
        }
        smallScale = false;
    }

    public String beautifyBytes(long byteCount) {
        String[] measure = {"B", "KB", "M", "GB", "TB"};
        int m = 0;
        float f = byteCount;

        while (f > 1024) {
            m++;
            f /= 1024;
        }
        while (f < -1024) {
            m++;
            f /= 1024;
        }
        return new String(decimalFormat.format(f) + " " + measure[m]);
    }

    public int getCountWithDefault(int count) {
        return testOnly ? 1 : count;
    }
}
