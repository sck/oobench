#include <iostream>
#include "ExceptionsBenchmark.cpp"

namespace oobench {

    class WithoutExceptionsPerformance : public ExceptionsBenchmark {
    public:
        WithoutExceptionsPerformance(int argc, const char** argv) 
                : ExceptionsBenchmark(argc, argv) { 
        }

        virtual int getMinorNumber() const {
            return 1;
        }

        static int simpleException() {
            return 1;
        }

        static int deepException2() {
            return 1;
        }

        static int deepException() {
            int result = deepException2();
            if (1 == result) {
                return 0;
            } else if (2 == result) {
                return 0;
            } 
            return result;
        }

        virtual void except(unsigned long items) {
            for (unsigned long i = 0; i < items; ++i) {
                if (simpleException() == 1) {
                }
            }
        }

        virtual void exceptDeep(unsigned long items) {
            for (unsigned long i = 0; i < items; ++i) {
                if (deepException() == 1) {
                }
            }
        }

    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("Exceptions");
    try {
        oobench::WithoutExceptionsPerformance performance(argc, argv);
        performance.test(500000L, "without exceptions");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
