package org.oobench.serialization;

import java.io.*;

public class SerializeClassComplexVersioned implements Serializable,
        SerializeClassInterface {
    static final long serialVersionUID = -2786282307951608201L;
    private SerializeClassComplexVersioned nodes[] = 
            new SerializeClassComplexVersioned[10];
    private int integer;
    private String string;

    public SerializeClassComplexVersioned() {
        this(1);
    }

    public SerializeClassComplexVersioned(int level) {
        if (1 == level) {
            string = "level1";
            integer = 1;
            for (int i = 0; i < 10; i++) {
                nodes[i] = new SerializeClassComplexVersioned(2);
            }
        } else if (2 == level) {
            string = "level2";
            integer = 2;
            for (int i = 0; i < 3; i++) {
                nodes[i] = new 
                        SerializeClassComplexVersioned("serializeTest", 23);
            }
        } 
    }

    public SerializeClassComplexVersioned(String theString, int theInteger) {
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
        if (!(string.equals("serializeTest") && integer == 23)) {
            System.err.println("Sanity check failed!");
        }
    }
}
