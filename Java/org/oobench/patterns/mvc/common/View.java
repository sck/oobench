/*
 * Abstract base class for views.
 */

package org.oobench.patterns.mvc.common;

public abstract class View extends Observer {

    private Model model;
    private Controller controller;

    public View(Model aModel) {
        model = aModel;
        controller = makeController();
        model.attach(this);
    }

    public void update() {
        draw();
    }

    public Model getModel() {
        return model;
    }

    public Controller getController() {
        return controller;
    }

    public abstract Controller makeController();

    public abstract void draw();
}
