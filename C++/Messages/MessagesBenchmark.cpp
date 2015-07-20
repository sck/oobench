#include "AbstractBenchmark.cpp"

namespace oobench {

    class MessagesBenchmark : public AbstractBenchmark {
    public:
        MessagesBenchmark(int argc, const char** argv) 
                : AbstractBenchmark(argc, argv) { 
        }

        virtual int getMajorNumber() const {
            return 5;
        }

        virtual int getMinorNumber() const {
            return 1;
        }

        virtual void invoke(unsigned long count) = 0;

        void test(unsigned long items, const char* description) {
            unsigned long count = getCountWithDefault(items);
            beginAction(1, "invoke", count, description);
            invoke(count);
            endAction();
        }
    };
}
