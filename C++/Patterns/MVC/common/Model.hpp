/*
 * Abstract base class for models.
 */

#ifndef _MODEL_H_
#define _MODEL_H_

namespace oobench {

    class Model {
        // TBD: use optimal data structure
        std::list<Observer*> observers;
    public:

        void attach(Observer& anObserver);
        void detach(Observer& anObserver);
        virtual ~Model();
        void notifyObservers();
    };
}

#endif
