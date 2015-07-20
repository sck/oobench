package org.oobench.patterns.proxy.common;

import java.lang.reflect.*;

public class Proxy implements java.lang.reflect.InvocationHandler {   

    Object obj;

    public static Object newInstance(Object obj) {
         return java.lang.reflect.Proxy.newProxyInstance(
                 obj.getClass().getClassLoader(),
                 obj.getClass().getInterfaces(),
                 new Proxy(obj));
    }     

    private Proxy(Object theObj) {
        obj = theObj;
    }

    public Object invoke(Object proxy, Method m, Object[] args) 
            throws Throwable {
        Object result;
        try {
            result = m.invoke(obj, args);
        } catch (InvocationTargetException e) {
            throw e.getTargetException();
        } catch (Exception e) {
            throw new RuntimeException
                ("unexpected invocation exception: " + e.getMessage());
        } 
        return result;
    }
}
