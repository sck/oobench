#include "AbstractBenchmark.cpp"

namespace oobench {

    class NumericsBenchmark : public AbstractBenchmark {
    public:
        NumericsBenchmark(int argc, const char** argv) 
                : AbstractBenchmark(argc, argv) { 
        }

        virtual int getMajorNumber() const {
            return 15;
        }

        virtual void algorithm(unsigned long count) = 0;

        void test(unsigned long items, const char* description) {
            unsigned long count = getCountWithDefault(items);
            std::cout << "*** Testing " << description << std::endl;
            algorithm(count);
        }
    };
}
