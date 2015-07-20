public class Statistics {

    public static void main(String[] args) {
        if (args.length < 2) {
            System.err.println("USAGE: " + System.getProperty("program.name") + 
                    " <ID file> <log file[,tag]> [<log file[,tag]> ...]");
            System.exit(1);
        }
        String idFile = args[0];

        ResultModel model = new ResultModel(
                new PrintStreamLogger(System.err));

        for (int i = 1; i < args.length; i++) {
            String rawLogFile = args[i];
            int comma = rawLogFile.lastIndexOf(',');
            String logFile;
            String tag;
            if (comma > -1) {
                logFile = rawLogFile.substring(0, comma);
                tag = rawLogFile.substring(comma + 1,
                        rawLogFile.length());
            } else {
                logFile = rawLogFile;
                tag = "";
            }
            ModelBuilder builder = new LogFileReader( 
                    new PrintStreamLogger(System.err), logFile, model, tag);
            builder.buildModel();
        }
        model.gatherStatistics();

        AnnotationModel annModel = new AnnotationModel(
                new PrintStreamLogger(System.err));
        ModelBuilder annBuilder = new IDFileReader(idFile, annModel);
        annBuilder.buildModel();

        ResultViewer viewer = new TextResultViewer(
                System.getProperty("program.name"), args, model,
                annModel, new PrintStreamLogger(System.err));
        viewer.showResult();
    }
}
