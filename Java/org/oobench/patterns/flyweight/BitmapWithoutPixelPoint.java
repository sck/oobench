package org.oobench.patterns.flyweight;

import java.util.*;

public class BitmapWithoutPixelPoint {
    private Screen screen;
    private byte[] pixels;

    public BitmapWithoutPixelPoint(Screen theScreen) {
        screen = theScreen;
        int screenSize = screen.getSize();
        pixels = new byte[screenSize];
        for (int i = 0; i < screenSize; i++) {
            pixels[i] = (byte)0;
        }
    }

    public void show() {
        DrawContext context = new DrawContext(screen);

        for (int i = 0; i < pixels.length; i++) {
            PixelPoint.draw(context, pixels[i]);
            context.next();
        }
    }

    public void showWithoutFlyweight() {
        DrawContext context = new DrawContext(screen);
        byte[] p = screen.getScreenBuffer();

        for (int i = 0; i < pixels.length; i++) {
            p[i] = pixels[i];
        }
    }

    public void showWithArraycopy() {
        DrawContext context = new DrawContext(screen);
        byte[] p = screen.getScreenBuffer();

        System.arraycopy(pixels, 0, p, 0, pixels.length);
    }
}
