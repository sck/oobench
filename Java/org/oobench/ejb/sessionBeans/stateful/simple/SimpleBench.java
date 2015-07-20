package org.oobench.ejb.sessionbeans.stateful.simple;

import javax.ejb.EJBObject;

public interface SimpleBench extends EJBObject {
    public void incrementCounter()
            throws java.rmi.RemoteException;

    public int getCounter()
            throws java.rmi.RemoteException;
}
