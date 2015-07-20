package org.oobench.ejb.common.deploy;

import java.io.*;
public class DirNotFoundException extends IOException {
    public DirNotFoundException() {
        super();
    }

    public DirNotFoundException(String s) {
        super(s);
    }
}
