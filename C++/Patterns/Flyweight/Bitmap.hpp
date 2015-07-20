#ifndef _BITMAP_H_
#define _BITMAP_H_

#include "Screen.hpp"
#include "DrawContext.hpp"
#include "PixelPoint.hpp"
#include <vector>

namespace oobench {

    class Bitmap {
        Screen& screen;
        std::vector<PixelPoint>* pixels;
    public:
        Bitmap(Screen& theScreen);
        virtual ~Bitmap();

        virtual void show();
        virtual void showWithoutFlyweight();
    };
}

#endif
