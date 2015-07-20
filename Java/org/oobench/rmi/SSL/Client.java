package org.oobench.rmi.ssl;

import java.rmi.*;
import org.oobench.rmi.*;

public class Client {

    public static void main(String args[]) {
        if (System.getSecurityManager() == null) { 
            System.setSecurityManager(new RMISecurityManager());
        }

        try {
            ClientInterface obj = (ClientInterface) Naming.lookup("/Server");
            int message = obj.incrementCounter(10);
            System.out.println(message);
        } catch (Exception e) {
            System.out.println("Client exception: " + e);
        }
    }
}
