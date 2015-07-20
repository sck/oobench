#include "MVC.hpp"
#include "ColorsModel.hpp"

namespace oobench {

    std::string& ColorsModel::getRGBForColor(std::string& color) {
        return colors[color];
    }

    std::map<std::string, std::string> ColorsModel::getColors() const {
        return colors;
    }
}
