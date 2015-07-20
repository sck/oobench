package org.oobench.patterns.flyweight;

public class PixelPoint {
    private byte pixel = 0;

    public PixelPoint(byte aPixel) {
        pixel = aPixel;
    }

    public static void draw(DrawContext dc, byte pixel) {
        dc.setCurrentByte(pixel);
    }

    public void draw(DrawContext dc) {
        dc.setCurrentByte(pixel);
    }

    public byte getPixel() {
        return pixel;
    }
};
