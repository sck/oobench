#include "Screen.hpp"

namespace oobench {

    Screen::Screen(long theSize) : size(theSize) {
        screen = new char[size];
    }

    Screen::~Screen() {
        delete[] screen;
    }

    long Screen::getSize() const {
        return size;
    }

    char* Screen::getScreenPointer() const {
        return screen;
    }
}
