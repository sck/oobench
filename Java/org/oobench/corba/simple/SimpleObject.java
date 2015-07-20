package org.oobench.corba.simple;

public class SimpleObject extends _SimpleImplBase {
    public int incrementCounter(int counter) {
        return ++counter;
    }
}
