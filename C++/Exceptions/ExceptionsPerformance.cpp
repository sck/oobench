#include <iostream>
#include "ExceptionsBenchmark.cpp"

namespace oobench {
    struct SyntaxError {
    };
    struct ZeroDivide {
    };
    struct Unexcpected {
    };

    class ExceptionsPerformance : public ExceptionsBenchmark {
    public:
        ExceptionsPerformance(int argc, const char** argv) 
                : ExceptionsBenchmark(argc, argv) { 
        }

        virtual int getMinorNumber() const {
            return 2;
        }

        static void simpleException() {
            throw ZeroDivide();
        }

        static void deepException2() {
            throw Unexcpected();
        }

        static void deepException() {
            try {
                deepException2();
            } catch (SyntaxError& se) {
            } catch (ZeroDivide& zd) {
            }
        }

        virtual void except(unsigned long items) {
            for (unsigned long i = 0; i < items; ++i) {
                try { 
                    simpleException();
                } catch (...) { 
                }
            }
        }

        virtual void exceptDeep(unsigned long items) {
            for (unsigned long i = 0; i < items; ++i) {
                try {
                    deepException();
                } catch (...) {
                }
            }
        }

    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("Exceptions");
    try {
        oobench::ExceptionsPerformance performance(argc, argv);
        performance.test(500000L, "exceptions");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
