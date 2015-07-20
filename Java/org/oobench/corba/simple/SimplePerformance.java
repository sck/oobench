package org.oobench.corba.simple;

import org.omg.CORBA.*;
import org.omg.CosNaming.*;

public class SimplePerformance extends CORBABenchmark {
    private static Simple simpleObj = null;

    public int getMinorNumber() {
        return 1;
    }

    public void simple(int count) {
        reset();
        for (int i = 0; i < count; i = simpleObj.incrementCounter(i)) {
            proceed();
        }
        reset();
    }

    public static void main(String args[]) {
        showLocation();
        try {
            ORB orb = ORB.init(args, null);
            org.omg.CORBA.Object contextObj =
                    orb.resolve_initial_references("NameService");
            NamingContext rootContext =
                    NamingContextHelper.narrow(contextObj);
            NameComponent name = new NameComponent("Simple", "");
            NameComponent path[] = { name };

            org.omg.CORBA.Object obj = rootContext.resolve(path);
            simpleObj = SimpleHelper.narrow(obj);

            SimplePerformance bench = new SimplePerformance();
            bench.setArguments(args);
            bench.test(5000, "simple");

            simpleObj._release();
        } catch (Exception e) {
            System.err.println("Exception: " + e);
            e.printStackTrace(System.err);
        }
    }
}
