package org.oobench.ejb.sessionbeans.stateful.simple;

import javax.ejb.EJBHome;

public interface SimpleHome extends EJBHome {
    SimpleBench create()
            throws java.rmi.RemoteException, javax.ejb.CreateException;
}
