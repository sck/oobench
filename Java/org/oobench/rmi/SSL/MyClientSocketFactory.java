package org.oobench.rmi.ssl;

import java.io.*;
import java.net.*;
import java.rmi.server.*;
import javax.net.ssl.*;

public class MyClientSocketFactory implements RMIClientSocketFactory,
        Serializable {

    public Socket createSocket(String host, int port) throws IOException {

        SSLSocketFactory factory = (SSLSocketFactory)
                SSLSocketFactory.getDefault();

        SSLSocket socket = (SSLSocket)factory.createSocket(host, port);
        return socket;
    }
}
