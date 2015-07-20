#include <iostream>
#include <cmath>
#include "NumericsBenchmark.cpp"

namespace oobench {
    template<typename PRECISION> std::string comment();

    template<> std::string comment<float>() {
        return "single precision";
    }

    template<> std::string comment<double>() {
        return "double precision";
    }

    template<> std::string comment<long double>() {
        return "long double precision";
    }

    template<typename PRECISION>
    class GaussPerformance : public NumericsBenchmark {
    public:
        GaussPerformance(int argc, const char** argv) :
                NumericsBenchmark(argc, argv) {
        }

        PRECISION gaussianRandBoxMuller(int mu, int sigma) {
            PRECISION x;
            PRECISION y;
            PRECISION r2;

            do {
                x = -1 + ((PRECISION)2.0 * rand() / (RAND_MAX +
                        (PRECISION)1.0));
                y = -1 + ((PRECISION)2.0 * rand() / (RAND_MAX +
                        (PRECISION)1.0));
                r2 = x * x + y * y;
            } while (r2 > (PRECISION)1.0 || r2 == (PRECISION)0.0);

            PRECISION n = mu + sigma * y * (PRECISION)sqrt(
                    (PRECISION)-2.0 * (PRECISION)log(r2) / r2);
            return n;
        }

        virtual void algorithm(unsigned long count) {
            beginAction(1, "gauss", count, comment<PRECISION>().c_str());
            for (unsigned long i = 0; i < count; ++i) {
                PRECISION n = gaussianRandBoxMuller(3, 6);
                n = n;
            }
            endAction();
        }

        virtual int getMinorNumber() const {
            return 1;
        }
    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("Numerics");
#define ITERATION_COUNT 5000000L 
    try {
        oobench::GaussPerformance<float> performance(argc, argv);
        performance.test(ITERATION_COUNT, "Gauss");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }

    try {
        oobench::GaussPerformance<double> performance(argc, argv);
        performance.test(ITERATION_COUNT, "Gauss");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }

    try {
        oobench::GaussPerformance<long double> performance(argc, argv);
        performance.test(ITERATION_COUNT, "Gauss");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
