package org.oobench.collections;

import java.io.*;
import java.util.*;
import java.lang.reflect.*;

public class SetBenchmark extends CollectionBenchmark {

    public static void testSetCollectionClass(Collection col, String[] args, 
            int theMinorNumber, String description, 
            String aRandomAccessComment, String aRemoveComment) {
        setRandomAccessComment(aRandomAccessComment);
        setRemoveComment(aRemoveComment);
        setGeneralComment(description);
        setMinorNumber(theMinorNumber);
        CollectionBenchmark bench = new CollectionBenchmark();
        bench.setArguments(args);
        wantSmallScaleForRandomAccess = false;
        bench.test(col, 500000);
        col = null;
    }
}
