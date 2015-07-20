package org.oobench.patterns.flyweight;

import java.util.*;

public class Bitmap {
    private Screen screen;
    private PixelPoint[] pixels;

    public Bitmap(Screen theScreen) {
        screen = theScreen;
        int screenSize = screen.getSize();
        pixels = new PixelPoint[screenSize];
        for (int i = 0; i < screenSize; i++) {
            pixels[i] = new PixelPoint((byte)0);
        }
    }

    public void show() {
        DrawContext context = new DrawContext(screen);

        for (int i = 0; i < pixels.length; i++) {
            pixels[i].draw(context);
            context.next();
        }
    }

}
