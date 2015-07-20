#include "InvalidRgbFormatException.hpp"

namespace oobench {

    InvalidRgbFormatException::InvalidRgbFormatException(
            const char* theMessage) : message(theMessage) { 
    }

    const char* InvalidRgbFormatException::getMessage() {
        return message;
    }
}
