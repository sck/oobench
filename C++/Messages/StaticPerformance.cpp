#include <iostream>
#include "MessagesBenchmark.cpp"

namespace oobench {

    class StaticPerformance : public MessagesBenchmark {
    public:
        StaticPerformance(int argc, const char** argv) 
                : MessagesBenchmark(argc, argv) { 
        }

        static void myStaticMethod() {
            int foo = 10;
            foo = foo;
        }

        virtual void invoke(unsigned long count) {
            for (unsigned long i = 0; i < count; ++i) {
                myStaticMethod();
            }
        }

    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("Messages");
    try {
        oobench::StaticPerformance performance(argc, argv);
        performance.test(500000000L, "static");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
