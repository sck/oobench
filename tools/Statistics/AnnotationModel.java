import java.util.*;

public class AnnotationModel {
    private Map annotations = new HashMap();
    private ErrorLogger logger;

    AnnotationModel(ErrorLogger aLogger) {
        logger = aLogger;
    }

    public void addAnnotationForID(String anID, String annotation) {
        if (!annotations.containsKey(anID)) {
            annotations.put(anID, annotation);
        } else {
            logger.logError("[" + anID + "] Has already an annotation!");
        }
    }

    public String getAnnotationForID(String anID) {
        if (annotations.containsKey(anID)) {
            return (String)annotations.get(anID);
        } else {
            logger.logError("[" + anID + "] Has no annotation, " + 
                    "returning empty string!");
            return "";
        }
    }
}
