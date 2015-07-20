package org.oobench.rmi.ssl;

import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;
import java.util.Date;
import org.oobench.rmi.*;

public class SSLServer extends UnicastRemoteObject implements
        ClientInterface {
    public SSLServer() throws RemoteException {
        super(0, new MyClientSocketFactory(), new
                MyServerSocketFactory());
    }

    public int incrementCounter(int i) throws RemoteException {
        return ++i;
    }
}
