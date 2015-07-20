package org.oobench.ejb.common;

import org.oobench.common.AbstractBenchmark;
import org.oobench.common.Stopwatch;
import org.oobench.common.ObjectScale;
import javax.naming.Context;
import org.oobench.ejb.common.initialcontext.ContextFactory;

public abstract class EJBBenchmark extends AbstractBenchmark {

    public int getMajorNumber() {
        return 14;
    }

    public abstract void performOperation(int count);
    public abstract void getLocalObject(Context ctx) throws Exception;

    public void test(int count, String description, 
            String applicationServer) {
        count = getCountWithDefault(count);
        System.out.println("*** Testing EJB (" + description + ")");

        beginAction(1, "getting local object", 1);
        try {
            Context ctx = 
                    ContextFactory.getInitialContext(applicationServer);
            getLocalObject(ctx);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
        endAction();

        beginAction(1, "performOperation", count);
        performOperation(count);
        endAction();
    }

    public static void testEJB(Class theClass, int count, 
            String description, String applicationServer, String[] args) {
        try {
            EJBBenchmark bench = (EJBBenchmark)theClass.newInstance();
            bench.setArguments(args);
            bench.test(count, description, applicationServer);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
    }
}
