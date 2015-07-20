#include "Bitmap.hpp"

namespace oobench {

    Bitmap::Bitmap(Screen& theScreen) : screen(theScreen) {
        pixels = new std::vector<PixelPoint>(screen.getSize());
    }

    Bitmap::~Bitmap() {
        delete pixels;
    }

    void Bitmap::show() {
        DrawContext context = DrawContext(screen);
        std::vector<PixelPoint>::iterator p = pixels->begin();

        while (p != pixels->end()) {
            (p++)->draw(context++);
        }
    }

    void Bitmap::showWithoutFlyweight() {
        char* scr = screen.getScreenPointer();
        std::vector<PixelPoint>::iterator p = pixels->begin();

        while (p != pixels->end()) {
            (*scr++) = (p++)->getPixel();
        }
    }
}
