public abstract class ResultViewer {
    protected String programName;
    protected String[] args;
    protected ResultModel model;
    protected ErrorLogger logger;
    protected AnnotationModel annModel;

    public String getProgramName() {
        return programName;
    }

    public String[] getArgs() {
        return args;
    }

    public ResultModel getModel() {
        return model;
    }

    public AnnotationModel getAnnModel() {
        return annModel;
    }

    public ErrorLogger getLogger() {
        return logger;
    }

    public abstract void showResult();
}
