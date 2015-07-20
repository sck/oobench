#include <iostream>
#include "MessagesBenchmark.cpp"

namespace oobench {

    class StaticInlinePerformance : public MessagesBenchmark {
    public:
        StaticInlinePerformance(int argc, const char** argv) 
                : MessagesBenchmark(argc, argv) { 
        }

        static inline void myStaticInlinedMethod() {
            int foo = 10;
            foo = foo;
        }

        virtual void invoke(unsigned long count) {
            for (unsigned long i = 0; i < count; ++i) {
                myStaticInlinedMethod();
            }
        }

    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("Messages");
    try {
        oobench::StaticInlinePerformance performance(argc, argv);
        performance.test(500000000L, "static inline");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
