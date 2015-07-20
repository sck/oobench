/*
 * Abstract base class for models.
 */

#include "MVC.hpp"

namespace oobench {

    Model::~Model() {
    }

    void Model::attach(Observer& anObserver) {
        observers.push_back(&anObserver);
    }

    void Model::detach(Observer& anObserver) {
        std::list<Observer*>::iterator p = 
                std::find(observers.begin(), observers.end(), &anObserver);
        if (p != observers.end()) {
            observers.erase(p);
        }
    }

    void Model::notifyObservers() {
        std::for_each(observers.begin(), observers.end(),
                std::mem_fun(&Observer::update));
    }
}
