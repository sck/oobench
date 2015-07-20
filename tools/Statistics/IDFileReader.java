import java.io.*;

public class IDFileReader implements ModelBuilder {
    private String idFile;
    private AnnotationModel model;

    IDFileReader(String theIDFile, AnnotationModel aModel) {
        idFile = theIDFile;
        model = aModel;
    }

    public void buildModel() {
        try {
            BufferedReader in = new BufferedReader(new FileReader(idFile));
            String line;

            while ( (line = in.readLine()) != null ) {
                boolean isAnnotation = (line.length() > 5)
                        && (!line.startsWith("#")) && (
                        ((line.charAt(0) >= '0' && line.charAt(0) <= '9') &&
                        (line.charAt(1) == ' ')) || 
                        ((line.charAt(1) == '.') && (line.charAt(4) == ' ')) ||
                        ((line.charAt(1) >= '0' && line.charAt(1) <= '9') &&
                        (line.charAt(2) == ' ')) ||
                        ((line.charAt(2) == '.') && (line.charAt(5) == ' '))
                        );

                if (isAnnotation) {
                    String ID = line.substring(0, line.indexOf(' '));
                    String annotation = line.substring(line.indexOf(' '),
                            line.length()).trim();
                    
                    model.addAnnotationForID(ID, annotation);
                }
            }
            in.close();
        } catch (IOException e) {
            System.err.println(e);
        }
    }
}
