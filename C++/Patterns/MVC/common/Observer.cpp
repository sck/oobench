/*
 * Common ancestor for view and controller.
 */

#ifndef _OBSERVER_CPP_
#define _OBSERVER_CPP_

namespace oobench {

    class Observer { 
    public:
        virtual void update() {
        }
    };
}

#endif
