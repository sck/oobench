package org.oobench.datafiles.properties;

import java.io.*;
import java.util.Properties;
import org.oobench.datafiles.common.DataFilesBenchmark;

public class PropertiesPerformanceSmall extends DataFilesBenchmark {
    public void writeAndRead(int count) {
        Properties properties = new Properties();
        properties.setProperty("counter", (new Integer(-1)).toString());

        try {
            for (int i = 0; i < count; i++) {
                FileOutputStream fout = new 
                        FileOutputStream(".tmp.properties");
                BufferedOutputStream out = new BufferedOutputStream(fout);
                properties.setProperty("counter", 
                        (new Integer(Integer.valueOf(
                        properties.getProperty("counter")).intValue() 
                        + 1).toString()) );
                properties.store(out, "Simple counter test");
                properties.clear();
                out.close();

                FileInputStream fin = new FileInputStream(".tmp.properties");
                BufferedInputStream in = new BufferedInputStream(fin);
                properties.load(in);
                in.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        showLocation();
        testDataFiles(PropertiesPerformanceSmall.class, 
            5000, "property files", args);
    }
}
