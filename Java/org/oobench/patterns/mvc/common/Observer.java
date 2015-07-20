/*
 * Common interface for view and controller.
 */

package org.oobench.patterns.mvc.common;

public class Observer {
    public void update() {
        System.out.println("You must override " +
                this.getClass().getName() + ".update()!");
    }
}
