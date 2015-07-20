public class IDResultItem {
    private String language;
    private String repetitions;
    private MilliSeconds milliSeconds;
    private String memoryUsed;
    private String annotation;
    private String comment;
    private int percentRatio;
    private String location;

    IDResultItem(String aLanguage, String someRepetitions, String
            someMilliSeconds, String someMemoryUsed, String anAnnotation,
            String aComment, String aLocation) {
        repetitions = someRepetitions;
        milliSeconds = new MilliSeconds(someMilliSeconds);
        memoryUsed = someMemoryUsed;
        language = aLanguage;
        annotation = anAnnotation;
        comment = aComment;
        location = aLocation;
    }

    public String getRepetitions() {
        return repetitions;
    }

    public MilliSeconds getMilliSeconds() {
        return milliSeconds;
    }

    public String getMemoryUsed() {
        return memoryUsed;
    }

    public String getLanguage() {
        return language;
    }

    public String getAnnotation() {
        return annotation;
    }

    public String getComment() {
        return comment;
    }

    public String getLocation() {
        return location;
    }

    public int getPercentRatio() {
        return percentRatio;
    }

    public void setPercentRatio(int ratio) {
        percentRatio = ratio;
    }
}
