package org.oobench.patterns.mvc;

import org.oobench.patterns.mvc.common.*;
import java.util.*;

public class MVCPerformance extends MVCBenchmark {
    private ColorsModel theModel;
    private View views[];

    public void create() {
        views = new View[200];
        theModel = new ColorsModel();
        for (int i = 0; i < 200; i++) {
            views[i] = new DumbColorsView(theModel, 
                    new Integer(i).toString());
        }
    }

    public void change(int items) {
        ColorsController controller = 
                (ColorsController)views[0].getController();
        StringBuffer colorName = new StringBuffer();
        StringBuffer rgbValue = new StringBuffer();

        reset();
        try {
            for (int i = 0; i < items; i++) {
                colorName.replace(0, colorName.length(), "x").
                        append(new Integer(i).toString());
                rgbValue.replace(0, rgbValue.length(), "#").
                        append(new Integer(i).toString());
                controller.addColorWithName(colorName.toString(), 
                        rgbValue.toString());
                proceed();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        reset();
    }

    public void check(int items) {
        for (int i = 0; i < views.length; i++) {
            if (((DumbColorsView)views[i]).getDrawCount() != items) {
                System.err.println("Warning: Draw count didn't match!");
            }
        }
    }

    public void remove(int items) {
        reset();
        views = null;
    }

    public static void main(String[] args) {
        showLocation();
        testMVC(MVCPerformance.class, 50000, args);
    }

}
