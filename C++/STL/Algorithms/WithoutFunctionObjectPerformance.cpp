#include <iostream>
#include "AlgorithmBenchmark.cpp"

namespace oobench {

    static long counter = 0;

    void myFunction() {
        ++counter;
    }

    class WithoutFunctionObjectPerformance : public AlgorithmBenchmark {
    public:
        WithoutFunctionObjectPerformance(int argc, const char** argv) 
                : AlgorithmBenchmark(argc, argv) { 
        }

        virtual int getMinorNumber() const {
            return 2;
        }

        virtual void performAction(long count)  {
            reset();
            for (long i = 0; i < count; ++i) {
                myFunction();
                proceed();
            }
            reset();
        }
    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("STL/Algorithms");
    try {
        oobench::WithoutFunctionObjectPerformance performance(argc, argv);
        performance.test(50000000L, "invoking with normal function");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
