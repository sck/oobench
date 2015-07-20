#ifndef _COLORS_MODEL_H_
#define _COLORS_MODEL_H_
#include "MVC.hpp"
#include <string>
#include <map>

namespace oobench {

    class ColorsModel : public Model {
        std::map<std::string, std::string> colors;
    public:
        std::string& getRGBForColor(std::string& color);
        std::map<std::string, std::string> getColors() const;
        inline void addColor(std::string name, std::string rgbValue);
    };

    // Implementation

    void ColorsModel::addColor(std::string name, std::string rgbValue) {
        colors[name] = rgbValue;
        notifyObservers();
    }
}
#endif
