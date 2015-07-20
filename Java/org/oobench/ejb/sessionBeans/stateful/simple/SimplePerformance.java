package org.oobench.ejb.sessionbeans.stateful.simple;

import java.util.Properties;
import javax.naming.Context;
import javax.naming.InitialContext;
import org.oobench.ejb.common.EJBBenchmark;

public class SimplePerformance extends EJBBenchmark {

    private SimpleBench simple;

    public int getMinorNumber() {
        return 1;
    }

    public void getLocalObject(Context ctx) throws Exception {
        try {
            Object objRef = ctx.lookup("SimpleBench");
            SimpleHome home = (SimpleHome)
                    javax.rmi.PortableRemoteObject.narrow(objRef,
                            SimpleHome.class);
            simple = home.create();
        } catch (Exception e) {
            throw new Exception("Failed to get local object: " +
                    e.toString());
        }
    }

    public void performOperation(int count) {
        reset();
        try {
            for (int i = 0; i < count; i++) {
                simple.incrementCounter();
                proceed();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        reset();
    }

    public static void main(String[] args) {
        showLocation();
        testEJB(SimplePerformance.class, 5000, "stateful session bean", 
                System.getProperty("oobench.application.server"), args );
    }
}
