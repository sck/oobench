#include "AbstractBenchmark.cpp"

namespace oobench {

    class ExceptionsBenchmark : public AbstractBenchmark {
    public:
        ExceptionsBenchmark(int argc, const char** argv) 
                : AbstractBenchmark(argc, argv) { 
        }

        virtual int getMajorNumber() const {
            return 3;
        }

        virtual void except(unsigned long items) = 0;
        virtual void exceptDeep(unsigned long items) = 0;

        virtual const char* getExceptionsComment() {
            return "";
        }

        void test(unsigned long items, const char* description) {
            long count = getCountWithDefault(items);
            std::cout << "*** Testing " << description << std::endl;

            beginAction(1, "except", count, getExceptionsComment());
            except(count);
            endAction();

            beginAction(2, "except deep", count, getExceptionsComment());
            exceptDeep(count);
            endAction();
        }
    };
}
