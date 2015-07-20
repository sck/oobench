package org.oobench.corba.common.taskdefs;

import java.util.*;
import java.io.*;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;
import org.apache.tools.ant.AntClassLoader;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.types.Commandline; 
import org.apache.tools.ant.types.Path;
import org.apache.tools.ant.types.Reference; 
import org.apache.tools.ant.util.*;


/**
 * Task to generate a skeleton from an IDL file.  This task accepts the
 * following arguments:
 * <ul>
 * <li>file: The idl file.</li>
 * <li>pkgPrefix: Package prefix for class.  Format: <package> <prefix>.</li>
 * <li>toDirectory: Directory where generated classes should be put.</li>
 * <li>options: Else options (see help for idlj).</li>
 * </ul>
 *
 * @author <a href="mailto:schween@snafu.de">Sven C. Koehler</a>
 */

public class Idlj extends Task {
    private String file;
    private String pkgPrefix;
    private String toDirectory;
    private String options;
    private AntClassLoader loader;

    public void execute() throws BuildException {
        StringBuffer cmd = new StringBuffer();

        if (null != pkgPrefix) {
            cmd.append(" -pkgPrefix " + pkgPrefix);
        }

        if (null != toDirectory) {
            cmd.append(" -td " + toDirectory);
        }

        if (null != options) {
            cmd.append(" " + options);
        }

        cmd.append(" " + file);
        log("IDLJ Compiling 1 class.", Project.MSG_INFO);
        log("Compilation args: " + cmd, Project.MSG_VERBOSE);

        String idljPath = project.getProperty("idlj.path");
        try {
            Runtime.getRuntime().exec(idljPath + cmd).waitFor();
        } catch (Exception e) {
            throw new BuildException(e);
        }
    }

    public void setFile(String theFile) {
        file = theFile;
    }

    public void setPkgPrefix(String thePkgPrefix) {
        pkgPrefix = thePkgPrefix;
        log("pkgPrefix: " + pkgPrefix);
    }

    public void setToDirectory(String theDir) {
        toDirectory = theDir;
    }

    public void setOptions(String theOptions) {
        options = theOptions;
    }
}
