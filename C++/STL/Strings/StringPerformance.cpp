#include "AbstractBenchmark.cpp"

namespace oobench {

    class StringPerformance : public AbstractBenchmark {
    public:
        StringPerformance(int argc, const char** argv) 
                : AbstractBenchmark(argc, argv) { 
        }

        virtual int getMajorNumber() const {
            return 1;
        }

        virtual int getMinorNumber() const {
            return 8;
        }

        void getStringByValue(std::string str) {
            str = str;
        }

        void passByValue(long count) {
            std::string str = std::string(40000, 'a');
            reset();
            for (long i = 0; i < count; ++i) {
                getStringByValue(str);
                proceed();
            }
            reset();
        }

        void getStringByReference(std::string& str) {
            str = str;
        }

        void passByReference(long count) {
            std::string str = std::string(40000, 'a');
            reset();
            for (long i = 0; i < count; ++i) {
                getStringByReference(str);
                proceed();
            }
            reset();
        }


        void test(long count) {
            count = getCountWithDefault(count);
            std::cout << "*** Benchmarking strings" << std::endl;
            beginAction(1, "passing", count, "by value");
            passByValue(count);
            endAction();
            beginAction(1, "passing", count, "by reference");
            passByReference(count);
            endAction();
        }
    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("STL/Strings");
    try {
        oobench::StringPerformance performance(argc, argv);
        performance.test(50000000L);
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
