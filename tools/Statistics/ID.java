public class ID {
    private String ID;
    private Integer majorNumber;
    private Integer minorNumber;
    private Integer subNumber;

    ID(String anID) {
        ID = anID;
        int dotIndex = ID.indexOf('.');
        int dot2Index = ID.indexOf('.', dotIndex + 1);
        majorNumber = new Integer(ID.substring(0, dotIndex)); 
        minorNumber = new Integer(ID.substring(dotIndex + 1, dot2Index));
        subNumber = new Integer(ID.substring(dot2Index + 1, ID.length()));
    }

    Integer getMajorNumber() {
        return majorNumber;
    }

    Integer getMinorNumber() {
        return minorNumber;
    }

    Integer getSubNumber() {
        return subNumber;
    }

    public int compareTo(Object o) {
        ID anID = (ID)o;
        int temp;

        temp = anID.getMajorNumber().compareTo(majorNumber);
        if (temp != 0) {
            return temp;
        }
        temp = anID.getMinorNumber().compareTo(minorNumber);
        if (temp != 0) {
            return temp;
        }
        return anID.getSubNumber().compareTo(subNumber);
    }

    public boolean equals(Object o) {
        return o.toString().equals(ID); 
    }

    public String toString() {
        return ID;
    }

    public int hashCode() {
        return toString().hashCode();
    }
}
