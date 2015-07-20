#ifndef _PIXELPOINT_H_
#define _PIXELPOINT_H_

#include "DrawContext.hpp"

namespace oobench {

    class PixelPoint {
        char pixel;
    public:
        inline PixelPoint(char thePixel = 0);
        inline void draw(DrawContext& dc);
        inline char getPixel();
    };

    // implementation

    PixelPoint::PixelPoint(char thePixel) : pixel(thePixel) {
    }

    void PixelPoint::draw(DrawContext& context) {
        *(context.getPointer()) = pixel;
    }

    char PixelPoint::getPixel() {
        return pixel;
    }
}

#endif
