package org.oobench.rmi.ssl;

import java.io.*;
import java.net.*;
import java.rmi.server.*;
import java.security.*;
import javax.net.ssl.*;
import javax.security.cert.*;
import com.sun.net.ssl.*;

public class MyServerSocketFactory implements RMIServerSocketFactory,
        Serializable {
    
    public ServerSocket createServerSocket(int port) throws IOException {
        SSLServerSocketFactory ssf = null;
        try {
            char[] passphrase = "secret".toCharArray();
            SSLContext ctx = SSLContext.getInstance("TLS");
            KeyManagerFactory kmf = KeyManagerFactory.getInstance("SunX509");
            KeyStore ks = KeyStore.getInstance("JKS");
            ks.load(new FileInputStream(".tmp.keystore"), passphrase);
            kmf.init(ks, passphrase);
            ctx.init(kmf.getKeyManagers(), null, null);
            ssf = ctx.getServerSocketFactory();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ssf.createServerSocket(port);
    }
}
