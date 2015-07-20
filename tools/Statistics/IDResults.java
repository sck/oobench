import java.util.*;

public class IDResults {
    private ID ID;
    private String repetitions;
    private String annotation;
    private List idResults = new LinkedList();
    private Map languageResults = new HashMap();
    private boolean haveComparison = false;

    IDResults(ID anID) {
        ID = anID;
    }

    public ID getID() {
        return ID;
    }

    public String getRepetitions() {
        return repetitions;
    }

    public String getAnnotation() {
        return annotation;
    }

    public void addIDResultItem(IDResultItem item, ErrorLogger logger) {
        String language = item.getLanguage();

        if (repetitions != null) {
            if (!repetitions.equals(item.getRepetitions())) {
                logger.logError("[" + ID + ":" + language + "] " +
                        "Repetition mismatch (" + repetitions + " != " + 
                        item.getRepetitions() + ")!");
            }
        } else {
            repetitions = item.getRepetitions();
        }

        if (annotation != null) {
            if (!annotation.equals(item.getAnnotation())) {
                logger.logError("[" + ID + ":" + language + "] " +
                        "Annotation mismatch (" + annotation + " != " + 
                        item.getAnnotation() + ")!");
            }
        } else {
            annotation = item.getAnnotation();
        }

        idResults.add(item);
    }

    public List getResultsSortedByTime() {
        List list = new LinkedList(idResults);
        Collections.sort(list, new Comparator() {
            public int compare(Object a, Object b) {
                return ((IDResultItem)a).getMilliSeconds().compareTo(
                        ((IDResultItem)b).getMilliSeconds());
            }
            public boolean equals(Object a, Object b) {
                return ((IDResultItem)a).getMilliSeconds().equals(
                        ((IDResultItem)b).getMilliSeconds());
            }
        });
        return list;
    }

    public List getResultsSortedByMemoryUsage() {
        List list = new LinkedList(idResults);
        Collections.sort(list, new Comparator() {
            public int compare(Object a, Object b) {
                return ((IDResultItem)a).getMemoryUsed().compareTo(
                        ((IDResultItem)b).getMemoryUsed());
            }
            public boolean equals(Object a, Object b) {
                return ((IDResultItem)a).getMemoryUsed().equals(
                        ((IDResultItem)b).getMemoryUsed());
            }
        });
        return list;
    }

    public IDResultItem getFastest() {
        List tempResults = new LinkedList();
        Iterator iter = idResults.iterator();
        while (iter.hasNext()) {
            IDResultItem idr = (IDResultItem)iter.next();
            if (!idr.getMilliSeconds().isEstimated()) {
                tempResults.add(idr);
            }
        }
        if (tempResults.size() == 0) {
            return (IDResultItem)(getResultsSortedByTime()).get(0);
        }
        return ((IDResultItem)Collections.min(tempResults, 
                new Comparator() {
                public int compare(Object a, Object b) {
                    return ((IDResultItem)a).getMilliSeconds().
                            getIntValue().compareTo(((IDResultItem)b).
                            getMilliSeconds().getIntValue());
                }

                public boolean equals(Object a, Object b) {
                    return ((IDResultItem)a).getMilliSeconds().equals(
                            ((IDResultItem)b).getMilliSeconds());
                }
        }));
    }

    public List getResults() {
        return Collections.unmodifiableList(idResults);
    }

    public Map getLanguageResults() {
        return Collections.unmodifiableMap(languageResults);
    }

    public void gatherStatistics() {
        float fastestMs = getFastest().getMilliSeconds()
                .getIntValue().intValue(); 
        if (fastestMs == 0) {
            fastestMs = 0.01f;
        }
        Iterator itemIter = idResults.iterator();
        while (itemIter.hasNext()) {
            IDResultItem result = (IDResultItem)itemIter.next();
            float ms = result.getMilliSeconds().getIntValue().intValue();
            if (ms == 0) {
                ms = 0.01f;
            }
            int percent = (int)((float)fastestMs /  ms * 100);
            result.setPercentRatio(percent);
            String language = result.getLanguage();

            if (languageResults.containsKey(language)) {
                Integer percentCurrent = 
                        (Integer)languageResults.get(language);
                if (percentCurrent.compareTo(new Integer(percent)) == -1) {
                    languageResults.put(language, new Integer(percent));
                }
            } else {
                languageResults.put(language, new Integer(percent));
            }
        }
        haveComparison = languageResults.size() > 1;
    }

    public boolean haveComparison() {
        return haveComparison;
    }
}
