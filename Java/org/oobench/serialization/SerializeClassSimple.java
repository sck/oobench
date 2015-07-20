package org.oobench.serialization;

import java.io.*;

public class SerializeClassSimple implements Serializable,
        SerializeClassInterface {
    private int integer;
    private String string;

    public SerializeClassSimple() {
        this("serializeTest", 23);
    }

    public SerializeClassSimple(String theString, int theInteger) {
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
