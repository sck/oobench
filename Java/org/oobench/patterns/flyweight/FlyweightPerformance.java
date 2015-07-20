package org.oobench.patterns.flyweight;

import org.oobench.common.*;

public class FlyweightPerformance extends AbstractBenchmark {
    private Bitmap bitmap;
    private BitmapWithoutPixelPoint bitmapWithoutPixelPoint;
    private Screen screen;
    private final int screenSize = 2000000;

    public int getMajorNumber() {
        return 8;
    }

    public int getMinorNumber() {
        return 3;
    }

    public void create() {
        screen = new Screen(screenSize);
        bitmap = new Bitmap(screen);
    }

    public void createWithoutPixelPoint() {
        bitmapWithoutPixelPoint = new BitmapWithoutPixelPoint(screen);
    }

    void draw(int count) {
        reset();
        for (int i = 0; i < count; i++) {
            bitmap.show();
            proceed();
        }
        reset();
    }

    void drawWithoutPixelPoint(int count) {
        reset();
        for (int i = 0; i < count; i++) {
            bitmapWithoutPixelPoint.show();
            proceed();
        }
        reset();
    }

    void drawWithoutFlyweight(int count) {
        reset();
        for (int i = 0; i < count; i++) {
            bitmapWithoutPixelPoint.showWithoutFlyweight();
            proceed();
        }
        reset();
    }

    void drawWithArraycopy(int count) {
        reset();
        for (int i = 0; i < count; i++) {
            bitmapWithoutPixelPoint.showWithArraycopy();
            proceed();
        }
        reset();
    }


    void test(int count) {
        count = getCountWithDefault(count);
        System.out.println("*** Benchmarking Flyweight");

        beginAction(1, "creating screen/bitmap, 2000000 pixel", 1);
        create();
        endAction();

        beginAction(1, "creating screen/bitmap, 2000000 pixel", 1, 
                "without PixelPoint");
        createWithoutPixelPoint();
        endAction();

        for (int c = 0; c < 10; c++) {
            if (c == 9) {
                beginAction(2, "drawing to virtual screen", count);
            }
            draw(count);
            if (c == 9) {
                endAction();
            }
            if (c == 9) {
                beginAction(2, "drawing to virtual screen", count,
                        "without PixelPoint");
            }
            drawWithoutPixelPoint(count);
            if (c == 9) {
                endAction();
                beginAction(2, "drawing to virtual screen", count,
                        "without PixelPoint, without Flyweight");
            }
            drawWithoutFlyweight(count);
            if (c == 9) {
                endAction();
                beginAction(2, "drawing to virtual screen", count,
                        "without PixelPoint, with System.arraycopy");
            }
            drawWithArraycopy(count);
            if (c == 9) {
                endAction();
            }
        }
        
    }

    public static void main(String[] args) {
        showLocation();
        FlyweightPerformance bench = new FlyweightPerformance();
        bench.setArguments(args);
        bench.test(20);
    }
}


