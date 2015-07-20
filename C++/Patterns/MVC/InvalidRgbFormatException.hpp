#ifndef _INVALID_RGB_FORMAT_EXCEPTION_HPP_
#define _INVALID_RGB_FORMAT_EXCEPTION_HPP_

namespace oobench {

    class InvalidRgbFormatException {
        const char* message;
    public:
        InvalidRgbFormatException(const char* theMessage);

        const char* getMessage();
    };
}

#endif
