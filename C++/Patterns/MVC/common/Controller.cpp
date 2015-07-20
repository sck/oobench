#include "MVC.hpp"

namespace oobench {

    Controller::Controller(View& theView): view(&theView) {
        view->getModel().attach(*this);
    }

    Controller::Controller(const Controller& anotherController) {
        view = anotherController.view;
        view->getModel().attach(*this);
    }

    void Controller::handleEvent(ControllerEvent& theEvent) {
    }

    void Controller::update() {
    }

    Controller::~Controller() {
        view->getModel().detach(*this);
    }
}
