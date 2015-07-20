package org.oobench.patterns.mvc;

import org.oobench.patterns.mvc.common.*;
import java.util.*;

public class ColorsModel extends Model {
    private Map colors = new HashMap();

    public String rgbForColor(String color) {
        return (String)colors.get(color);
    }

    public Map getColors() {
        return colors;
    }

    public void addColorWithName(String name, String rgbValue) {
        colors.put(name, rgbValue);
        notifyObservers();
    }
}
