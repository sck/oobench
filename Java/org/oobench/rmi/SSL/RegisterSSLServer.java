package org.oobench.rmi.ssl;

import java.rmi.*;

public class RegisterSSLServer {
    public static void main(String args[]) {
        try {
            System.out.println("RegisterSSLServer: start");
            SSLServer obj = new SSLServer();
            System.out.println("Object instantiated: " + obj);
            Naming.rebind("/Server", obj);
            System.out.println("SSLServer bound in registry");
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
