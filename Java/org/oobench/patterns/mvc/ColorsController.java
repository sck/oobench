package org.oobench.patterns.mvc;

import org.oobench.patterns.mvc.common.*;

public class ColorsController extends Controller {

    public ColorsController(View theView) {
        super(theView);
    }

    public void handleEvent(ControllerEvent theEvent) {
    }

    public void addColorWithName(String name, String rgbValue) 
            throws InvalidRgbFormatException {
        if (!rgbValue.startsWith("#")) {
            throw new InvalidRgbFormatException(
                    "rgbValue needs to start with '#'");
        }
        ((ColorsModel)getView().getModel()).addColorWithName(name, rgbValue);
    }

    public void update() {
    }
}
