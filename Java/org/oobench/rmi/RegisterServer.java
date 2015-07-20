package org.oobench.rmi;

import java.rmi.*;

public class RegisterServer {
    public static void main(String args[]) {
        try {
            Server obj = new Server();
            System.out.println("Object instantiated: " + obj);
            Naming.rebind("/Server", obj);
            System.out.println("Server bound in registry");
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
