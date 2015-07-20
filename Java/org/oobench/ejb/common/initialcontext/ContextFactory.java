package org.oobench.ejb.common.initialcontext;

import java.util.Properties;
import java.lang.reflect.*;
import javax.naming.Context;
import javax.naming.InitialContext;

public class ContextFactory {

    public static Context getInitialContext(String applicationServer) 
            throws Exception {
        String methodName = "get" + applicationServer + "InitialContext";
        Method method = null;
        try {
            Class [] argTypes = {};
            method = ContextFactory.class.getMethod(methodName,
                    argTypes);
        } catch (Exception e) {
            throw new Exception("Could not invoke " + methodName + 
                    " in class " + ContextFactory.class.getName() + ": " +
                    e.toString());
        }
        try {
            Object[] args = {};
            return (Context)method.invoke(null, args);
        } catch (InvocationTargetException ite) {
            throw new Exception("Invocation failed: " + 
                    ContextFactory.class.getName() + "." + methodName +
                    "\n" + "Root cause: " + ite.getTargetException());
        } catch (Exception e) {
            throw new Exception("Invocation failed: " + 
                    ContextFactory.class.getName() + "." + methodName + ": " +
                    e.toString());
        }
    }

    public static Context getJBossInitialContext() throws Exception {
        Properties prop = new Properties();
        prop.put(Context.INITIAL_CONTEXT_FACTORY,
                "org.jnp.interfaces.NamingContextFactory");
        prop.put(Context.PROVIDER_URL, "localhost:1099");
        return new InitialContext(prop);
    }

    public static Context getWeblogicInitialContext() throws Exception {
        Properties prop = new Properties();
        prop.put(Context.INITIAL_CONTEXT_FACTORY, 
                "weblogic.jndi.WLInitialContextFactory");
        prop.put(Context.PROVIDER_URL, "t3://localhost:7001");
        //if (user != null) {
        //log ("user: " + user);
        //prop.put(Context.SECURITY_PRINCIPAL, "sven");
        //if (password == null)
        //  password = "";
        //h.put(Context.SECURITY_CREDENTIALS, password);
        //prop.put(Context.SECURITY_CREDENTIALS, "blablabla");
        return new InitialContext(prop);
    }

    public static Context getDynamoInitialContext() throws Exception {
         return new InitialContext();
    }

    public static Context getOrionInitialContext() throws Exception {
        Properties prop = new Properties();
        prop.put(Context.INITIAL_CONTEXT_FACTORY, 
                "com.evermind.server.ApplicationClientInitialContextFactory");
        prop.put(Context.PROVIDER_URL, "ormi://localhost/SimpleBench");
        prop.put(Context.SECURITY_PRINCIPAL, "admin");
        prop.put(Context.SECURITY_CREDENTIALS, "blablabla");
        return new InitialContext(prop);
    }

    public static Context getJ2SDKEEInitialContext() throws Exception {
        return new InitialContext();
    }
}
