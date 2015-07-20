package org.oobench.serialization;

import java.io.*;

public class SerializeClassComplex implements Serializable,
        SerializeClassInterface {
    private SerializeClassComplex nodes[] = new SerializeClassComplex[10];
    private int integer;
    private String string;

    public SerializeClassComplex() {
        this(1);
    }

    public SerializeClassComplex(int level) {
        if (1 == level) {
            string = "level1";
            integer = 1;
            for (int i = 0; i < 10; i++) {
                nodes[i] = new SerializeClassComplex(2);
            }
        } else if (2 == level) {
            string = "level2";
            integer = 2;
            for (int i = 0; i < 3; i++) {
                nodes[i] = new SerializeClassComplex("serializeTest", 23);
            }
        } 
    }

    public SerializeClassComplex(String theString, int theInteger) {
        integer = theInteger;
        string = theString;
    }
 
    private void writeObject(ObjectOutputStream out) throws IOException {
        out.defaultWriteObject();
    }
    
    private void readObject(ObjectInputStream in) throws IOException {
        try {
            in.defaultReadObject();
        } catch (ClassNotFoundException cnfe) { 
        }
    }

    public void check() {
        if (!(string.equals("serializeTest") && 23 == integer)) {
            System.err.println("Sanity check failed!");
        }
    }
}
