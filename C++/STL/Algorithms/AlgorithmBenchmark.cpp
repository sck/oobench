#include "AbstractBenchmark.cpp"

namespace oobench {

    class AlgorithmBenchmark : public AbstractBenchmark {
    public:
        AlgorithmBenchmark(int argc, const char** argv) 
                : AbstractBenchmark(argc, argv) { 
        }

        virtual int getMajorNumber() const {
            return 2;
        }

        virtual void performAction(long count) {
            // Default is to show an error message.  Should be overridden in
            // all subclasses, that do not define their own test() member
            // function.
            std::cerr << "You need to override performAction()!" <<
                    std::endl;
        }

        void test(long count, const char* description) {
            count = getCountWithDefault(count);
            beginAction(1, description, count);
            performAction(count);
            endAction();
        }
    };
}
