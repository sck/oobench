/*
 * Common base class for controllers.
 */

#ifndef _CONTROLLER_H_
#define _CONTROLLER_H_

namespace oobench {

    class Controller : public Observer {
        View* view;
    public:
        virtual void handleEvent(ControllerEvent&);
        Controller(View& theView);
        Controller(const Controller& anotherController);
        virtual ~Controller();
        virtual void update();
        inline View& getView() const;
    };
    
    // Implementation

    View& Controller::getView() const {
        return *view;
    }
}

#endif
