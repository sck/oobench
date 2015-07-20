package org.oobench.ejb.common.deploy;

import java.util.*;
import java.lang.reflect.*;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;

/**
 * Task to deploy ejb jar to application server.  This task accepts the
 * following arguments:
 * <ul>
 * <li>sourcejar: The ejb jar file to deploy.</li>
 * <li>targetAS: The target application server.</li>
 * <li>targetASdir: Directory of the application server.</li>
 * </ul>
 *
 * Upon execute(), the actual work is delegated to the class denoted
 * by targetAS in this package.
 * 
 * @author <a href="mailto:schween@snafu.de">Sven C. Koehler</a>
 */

public class DeployFactory extends Task {
    private String sourceJar;
    private String targetApplicationServer;
    private String targetASdir;

    public DeployFactory() {
    }

    public void execute() throws BuildException {
        String className = this.getClass().getName();
        String deployerClassName =
                className.substring(0, className.lastIndexOf(".")) + 
                "." + targetApplicationServer;

        DeployerInterface deployer;
        try {
            Class deployerClass = Class.forName(deployerClassName);

            Class[] parameterTypes = { Task.class, String.class, 
                    String.class };
            Object[] initArgs = { this, new String(sourceJar), 
                    new String(targetASdir) };

            Constructor ctor = deployerClass.getConstructor(parameterTypes);
            deployer = (DeployerInterface) ctor.newInstance(initArgs);
        } catch (Exception e) {
            throw new BuildException("Failed loading " +
                    deployerClassName + ": " + e.toString());
        }

        try { 
            deployer.deploy();
        } catch (Exception e) {
            throw new BuildException("Failed deploying " + sourceJar +
                    ": " + e.toString());
        }
    }

    public void setSourceJar(String theSourceJar) {
        sourceJar = theSourceJar;
    }

    public void setTargetasdir(String theTargetASdir) {
        targetASdir = theTargetASdir;
    }

    public void setTargetas(String theTargetAS) {
        targetApplicationServer = theTargetAS;
    }
}
