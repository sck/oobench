package org.oobench.corba.simple;

import org.omg.CORBA.*;
import org.omg.CosNaming.*;

public class SimpleServer {
    public static void main(String args[]) {
        try {
            ORB orb = ORB.init(args, null);
            SimpleObject impl = new SimpleObject();
            // "NameService" gives us the root context of the Naming
            // Service.
            org.omg.CORBA.Object contextObj =
                    orb.resolve_initial_references("NameService");
            NamingContext rootContext =
                    NamingContextHelper.narrow(contextObj);
            NameComponent name = new NameComponent("Simple", "");
            NameComponent path[] = { name };
            rootContext.rebind(path, impl);

            java.lang.Object sync = new java.lang.Object();
            synchronized (sync) {
                sync.wait();
            }
        } catch (Exception e) {
            System.err.println("Failed to register object: " + e);
            e.printStackTrace(System.err);
        }
    }
}
