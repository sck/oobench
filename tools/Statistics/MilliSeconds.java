public class MilliSeconds {
    private String milliSeconds;
    private Integer intValue;
    private boolean estimated;

    MilliSeconds(String someMilliSeconds) {
        milliSeconds = someMilliSeconds;
        StringBuffer temp = new StringBuffer(someMilliSeconds);
        if ((temp.toString()).endsWith("ms")) {
            temp.setLength(temp.length() - 2);
        }
        temp = new StringBuffer((temp.toString()).trim());
        if ((temp.toString()).endsWith("e")) {
            temp.setLength(temp.length() - 1);
            estimated = true;
        } else {
            estimated = false;
        }
        intValue = new Integer(temp.toString());
    }

    public int compareTo(Object o) {
        return intValue.compareTo(((MilliSeconds)o).getIntValue());
    }

    public Integer getIntValue() {
        return intValue;
    }

    public boolean isEstimated() {
        return estimated;
    }

    public String toString() {
        return milliSeconds + " ms";
    }
}
