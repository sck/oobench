import java.io.*;

public class LogFileReader implements ModelBuilder {
    private String logFile;
    private ResultModel model;
    private String tag;
    private ErrorLogger logger;

    LogFileReader(ErrorLogger aLogger, String aLogFile, ResultModel aModel, 
            String aTag) {
        logger = aLogger;
        logFile = aLogFile;
        model = aModel;
        tag = aTag;
    }

    public void buildModel() {
        try {
            BufferedReader in = new BufferedReader(new FileReader(logFile));
            String location = "";
            String line;

            while ( (line = in.readLine()) != null ) {
                if (line.startsWith("Location: ")) {
                    location = line.substring(line.indexOf("Location: ") + 10, 
                            line.length());
                } else {
           // ^Java: [1.2.4] remove (500000) -- comment: 5000e ms (-3920.0 B+?)$
                    int colonPos = line.indexOf(':');
                    int bracketStart = line.indexOf('[');
                    int bracketEnd = line.indexOf(']');
                    int parenStart = line.indexOf('(');
                    int parenEnd = line.indexOf(')');
                    int msPos = line.indexOf("ms");
                    int memoryParenStart = line.lastIndexOf('(');
                    int memoryParenEnd = line.lastIndexOf(')');
                    int commentStart = line.indexOf(" -- ");
                    int commentEnd = line.lastIndexOf(':');
                    int milliSecondsStart = (commentEnd > 0 ? 
                            commentEnd + 2 : parenEnd + 3);
                    boolean lineLooksLikeBenchmarkResult = 
                            memoryParenEnd > memoryParenStart &&
                            memoryParenEnd > msPos &&
                            msPos > parenEnd &&
                            parenEnd > parenStart &&
                            parenStart > bracketEnd &&
                            bracketEnd > bracketStart &&
                            bracketStart > colonPos;

                    if (lineLooksLikeBenchmarkResult) {
                        String language = line.substring(0, colonPos);
                        String ID = line.substring(bracketStart + 1, bracketEnd);
                        String repetitions = line.substring(parenStart + 1, 
                                parenEnd);
                        String milliSeconds = line.substring(milliSecondsStart,
                                line.indexOf(' ', milliSecondsStart));
                        String memoryUsed = line.substring(
                                memoryParenStart + 1, memoryParenEnd);
                        String annotation = line.substring(
                                bracketEnd + 2, parenStart - 1);
                        String comment = "";
                        if (commentStart > 0 && commentEnd > 0) {
                            comment = line.substring(commentStart + 4,
                                    commentEnd);
                        }

                        if (location.equals("")) {
                            logger.logError("[" + ID.toString() + 
                                    "] Location not defined!");
                        }
                        model.addResultForID(ID, 
                                (!tag.equals("") ? tag + ":" : "") + language, 
                                repetitions, milliSeconds, memoryUsed, 
                                annotation, comment, location);
                    }
                }
            }
            in.close();
        } catch (IOException e) {
            System.err.println(e);
        }
    }
}
