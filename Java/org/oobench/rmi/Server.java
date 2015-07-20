package org.oobench.rmi;

import java.io.*;
import java.rmi.*;
import java.rmi.server.*;
import java.util.Date;

public class Server extends UnicastRemoteObject implements
        ClientInterface {
    public Server() throws RemoteException {
        super();
    }

    public int incrementCounter(int i) throws RemoteException {
        return ++i;
    }
}
