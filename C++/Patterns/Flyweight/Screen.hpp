#ifndef _SCREEN_H_
#define _SCREEN_H_

namespace oobench {

    class Screen {
        char* screen;
        long size;
    public:
        Screen(long theSize = 20000);
        ~Screen();

        long getSize() const;
        char* getScreenPointer() const;
    };
}

#endif
