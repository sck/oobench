#ifndef _DRAWCONTEXT_H_
#define _DRAWCONTEXT_H_

#include "Screen.hpp"

namespace oobench {

    class DrawContext {
        char* pointer;
    public:
        inline DrawContext(Screen& theScreen);

        inline void next(int step = 1);
        inline char* getPointer() const;
        inline DrawContext& operator++(int step);
    };

    // implementation

    DrawContext::DrawContext(Screen& theScreen) :
            pointer(theScreen.getScreenPointer()) { 
    }

    void DrawContext::next(int step) {
        pointer += step;
    }

    DrawContext& DrawContext::operator++(int step) {
        pointer += step;
        return *this;
    }

    char* DrawContext::getPointer() const {
        return pointer;
    }
}

#endif
