package org.oobench.ejb.sessionbeans.stateful.simple;

import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

public class SimpleEJB implements SessionBean {
    private int counter;

    public void ejbActivate() { }

    public void ejbPassivate() { }

    public void ejbRemove() { }

    public void ejbCreate() { 
    }

    public void setSessionContext(SessionContext ctx) { }

    public void incrementCounter() {
        counter++;
    }

    public int getCounter() {
        return counter;
    }
}

