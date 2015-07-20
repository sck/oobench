package org.oobench.ejb.common.deploy;

import java.io.*;

public class FileExistsAlreadyException extends IOException {
    public FileExistsAlreadyException() {
        super();
    }

    public FileExistsAlreadyException(String s) {
        super(s);
    }
}
