import java.util.*;

// TODO: Don't "return null", use exceptions instead!

public class ResultModel {
    private Map results = new HashMap();
    private ErrorLogger logger;
    private Map sectionAverageRatios = new HashMap();
    private Map minorSectionsLocations = new HashMap();

    ResultModel(ErrorLogger aLogger) {
        logger = aLogger;
    }

    public void addResultForID(String anID, String language, 
            String repetitions, String milliSeconds, String memoryUsed,
            String annotation, String comment, String location) {
        ID ID = new ID(anID);
        if (!results.containsKey(ID)) {
            results.put(ID, new IDResults(ID));
        }
        ((IDResults)results.get(ID)).
                addIDResultItem(new IDResultItem(language,
                repetitions, milliSeconds, memoryUsed, annotation,
                comment, location), logger);
    }

    IDResults getResultsForID(ID ID) {
        return (IDResults)results.get(ID);
    }

    List getIDs() {
        List list = new LinkedList(results.keySet());
        Collections.sort(list, new Comparator() {
            public int compare(Object a, Object b) {
                return ((ID)a).compareTo((ID)b) * -1;
            }
            public boolean equals(Object a, Object b) {
                return ((ID)a).equals((ID)b);
            }
        });
        return list;
    }

    private void storeResult(Map sectionResults, String language,
            Integer percent, String sectionID) {
        if (!sectionResults.containsKey(sectionID)) {
            sectionResults.put(sectionID, new HashMap());
        }
        Map languageResults = (Map)sectionResults.get(sectionID);
        if (!languageResults.containsKey(language)) {
            languageResults.put(language, new LinkedList());
        }
        List ratios = (List)languageResults.get(language);
        ratios.add(percent);
    }

    private Integer getAverage(List ints) {
        Iterator iter = ints.iterator();
        int result = 0;
        while (iter.hasNext()) {
            Integer i = (Integer)iter.next();
            result += i.intValue();
        }
        return new Integer(result > 0 ? result / ints.size() : 0);
    }

    public List getSortedSectionAverages(String section) {
        if (!sectionAverageRatios.containsKey(section)) {
            return null;
        }
        Map langRatios = (Map)sectionAverageRatios.get(section);
        List results = new LinkedList();
        Iterator ratioIter = langRatios.keySet().iterator();
        while (ratioIter.hasNext()) {
            String language = (String)ratioIter.next();
            Integer averageRatio = (Integer)langRatios.get(language);
            List result = new LinkedList();
            result.add(language);
            result.add(averageRatio);
            results.add(result);
        }
        Collections.sort(results, new Comparator() {
            public int compare(Object a, Object b) {
                return ((Integer)((List)a).get(1))
                        .compareTo(((List)b).get(1)) * -1;
            }
            public boolean equals(Object a, Object b) {
                return ((Integer)((List)a).get(1))
                        .equals((Integer)((List)b).get(1));
            }
        });
        return results;
    }

    public List getSortedTotals() {
        return getSortedSectionAverages("0.0.0");
    }

    void gatherStatistics() {
        Map sectionResults = new HashMap();
        Iterator sectionsIter = results.keySet().iterator();

        while (sectionsIter.hasNext()) {
            IDResults section = 
                    (IDResults)results.get((ID)sectionsIter.next());
            section.gatherStatistics();

            if (section.haveComparison()) {
                ID sectionID = section.getID();
                Map sectionLanguageResults = section.getLanguageResults();
                Iterator langIter = sectionLanguageResults.keySet().iterator();

                while (langIter.hasNext()) {
                    String language = (String)langIter.next();
                    Integer percent =
                            (Integer)sectionLanguageResults.get(language);
                    storeResult(sectionResults, language, percent, 
                            sectionID.getMajorNumber().toString());
                    storeResult(sectionResults, language, percent, 
                            sectionID.getMajorNumber() + "." + 
                            sectionID.getMinorNumber().toString());
                    storeResult(sectionResults, language, percent,
                            sectionID.toString());
                    storeResult(sectionResults, language, percent, "0.0.0");
                }
            }
        }
        
        Iterator sectionIter = sectionResults.keySet().iterator();
        while (sectionIter.hasNext()) {
            String section = (String)sectionIter.next();
            Map langRatios = (Map)sectionResults.get(section);
            Iterator ratioIter = langRatios.keySet().iterator();
            while (ratioIter.hasNext()) {
                String language = (String)ratioIter.next();
                if (!sectionAverageRatios.containsKey(section)) {
                    sectionAverageRatios.put(section, new HashMap());
                }
                Map languageRatio = (Map)sectionAverageRatios.get(section);
                languageRatio.put(language, 
                        getAverage((List)langRatios.get(language)));
            }
        }

        gatherMinorLocations();
    }

    private void gatherMinorLocations() {
        Iterator sectionsIter = results.keySet().iterator();

        while (sectionsIter.hasNext()) {
            IDResults section = 
                    (IDResults)results.get((ID)sectionsIter.next());
            section.gatherStatistics();

            ID sectionID = section.getID();
            Iterator resultIter = section.getResults().iterator();
            String minorID = section.getID().getMajorNumber() + 
                    "." + section.getID().getMinorNumber();

            if (!minorSectionsLocations.containsKey(minorID)) {
                minorSectionsLocations.put(minorID, new HashMap());
            }
            Map locations = (Map)minorSectionsLocations.get(minorID);

            while (resultIter.hasNext()) {
                IDResultItem item = (IDResultItem)resultIter.next();
                String language = item.getLanguage();

                if (!locations.containsKey(language)) {
                    locations.put(language, item.getLocation());
                }
            }
        }
    }

    public List getLocationsForMinorSection(String minorSection) {
        if (!minorSectionsLocations.containsKey(minorSection)) {
            return null;
        }
        List result = new LinkedList();
        Map locations = (Map)minorSectionsLocations.get(minorSection);
        Iterator locIter = (locations).keySet().iterator();

        while (locIter.hasNext()) {
            String language = (String)locIter.next();
            String location = (String)locations.get(language);
            List item = new LinkedList();
            item.add(language);
            item.add(location);
            result.add(item);
        }
        return result;
    }
}
