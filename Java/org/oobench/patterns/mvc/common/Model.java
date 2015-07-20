/*
 * Base class for models.
 */

package org.oobench.patterns.mvc.common;

import java.util.*;

public class Model {
    private Collection observers = new LinkedList();

    public void attach(Observer anObserver) {
        observers.add(anObserver);
    }

    public void detach(Observer anObserver) {
        observers.remove(anObserver);
    }

    public void notifyObservers() {
        Iterator iter = observers.iterator();
        while (iter.hasNext()) {
            Observer observer = (Observer)iter.next();
            observer.update();
        }
    }
}
