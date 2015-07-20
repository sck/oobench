import java.io.*;

public class PrintStreamLogger implements ErrorLogger {
    private PrintStream stream; 

    PrintStreamLogger(PrintStream aStream) {
        stream = aStream;
    }

    public void logError(String error) {
        stream.println(error);
    }
}
