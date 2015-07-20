package org.oobench.ejb.common.deploy;

import org.apache.tools.ant.BuildException;

interface DeployerInterface {
    public void deploy() throws BuildException;
}
