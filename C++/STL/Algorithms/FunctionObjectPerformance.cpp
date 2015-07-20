#include <iostream>
#include "AlgorithmBenchmark.cpp"

namespace oobench {

    class FunctionObject {
        long counter;

    public:
        FunctionObject() { 
            counter = 0;
        }

        void operator()() {
            ++counter;
        }
    };

    class FunctionObjectPerformance : public AlgorithmBenchmark {
    public:
        FunctionObjectPerformance(int argc, const char** argv) 
                : AlgorithmBenchmark(argc, argv) { 
        }

        virtual int getMinorNumber() const {
            return 1;
        }

        virtual void performAction(long count)  {
            FunctionObject functionObject;
            reset();
            for (long i = 0; i < count; ++i) {
                functionObject();
                proceed();
            }
            reset();
        }
    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("STL/Algorithms");
    try {
        oobench::FunctionObjectPerformance performance(argc, argv);
        performance.test(50000000L, "invoking function object");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
