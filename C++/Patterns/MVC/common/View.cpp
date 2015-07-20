/*
 * Abstract base class for views.
 */

#include "MVC.hpp"

namespace oobench {

    View::View(Model& theModel): model(&theModel) {
        controller = makeController();
        model->attach(*this);
    }

    View::View(const View& anotherView) {
        controller = makeController();
        model = anotherView.model;
        model->attach(*this);
    }

    View::~View() {
        model->detach(*this);
        delete controller;
    }

    void View::update() {
        draw();
    }

    Controller* View::makeController() {
        return new Controller(*this);
    }

    Controller& View::getController() const {
        return *controller;
    }
}
