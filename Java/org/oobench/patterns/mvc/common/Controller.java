/*
 * Base class for controllers.
 */

package org.oobench.patterns.mvc.common;

public abstract class Controller extends Observer {

    private View view;

    public Controller(View theView) {
        view = theView;
        view.getModel().attach(this);
    }

    public abstract void handleEvent(ControllerEvent theEvent);

    public void unregister() {
        view.getModel().detach(this);
    }

    public View getView() {
        return view;
    }
}
