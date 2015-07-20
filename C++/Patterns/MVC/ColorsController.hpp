#ifndef _COLORS_CONTROLLER_H_
#define _COLORS_CONTROLLER_H_

#include "MVC.hpp"
#include <string>
#include "ColorsModel.hpp"
#include "InvalidRgbFormatException.hpp"

namespace oobench {

    class ColorsController : public Controller {
    public:
        ColorsController(View& theView);
        inline void addColor(std::string name, std::string rgbValue);
    };

    // Implementation

    void ColorsController::addColor(std::string name, std::string rgbValue) {
        if (rgbValue[0] != '#') {
            throw InvalidRgbFormatException("rgbValue needs to start with '#'");
        }
        ((ColorsModel&)getView().getModel()).addColor(name, rgbValue);
    }
}
#endif
