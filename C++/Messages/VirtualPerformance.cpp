#include <iostream>
#include "MessagesBenchmark.cpp"

namespace oobench {

    class VirtualPerformance : public MessagesBenchmark {
    public:
        VirtualPerformance(int argc, const char** argv) 
                : MessagesBenchmark(argc, argv) { 
        }

        virtual void myVirtualMethod() {
            int foo = 10;
            foo = foo;
        }

        virtual void invoke(unsigned long count) {
            for (unsigned long i = 0; i < count; ++i) {
                myVirtualMethod();
            }
        }

    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("Messages");
    try {
        oobench::VirtualPerformance performance(argc, argv);
        performance.test(500000000L, "virtual");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
