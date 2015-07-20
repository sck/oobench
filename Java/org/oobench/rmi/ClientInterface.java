package org.oobench.rmi;

public interface ClientInterface extends java.rmi.Remote {
    public int incrementCounter(int i) throws java.rmi.RemoteException;
}
