package org.oobench.patterns.flyweight;

public class Screen {

    private int size;
    private byte[] screen;

    public Screen(int theSize) {
        size = theSize;
        screen = new byte[size];
    }

    public int getSize() {
        return size;
    }

    public byte[] getScreenBuffer() {
        return screen;
    }
}

