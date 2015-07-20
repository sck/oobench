#include "AbstractBenchmark.cpp"

namespace oobench {

    class MVCBenchmark : public AbstractBenchmark {
    public:
        MVCBenchmark(int argc, const char** argv) 
                : AbstractBenchmark(argc, argv) { 
        }

        virtual int getMajorNumber() const {
            return 8;
        }

        virtual int getMinorNumber() const {
            return 1;
        }

        virtual void create() = 0;
        virtual void change(unsigned long items) = 0;
        virtual void check(unsigned long items) = 0;
        virtual void remove(unsigned long items) = 0;

        void test(unsigned long items) {
            items = getCountWithDefault(items);
            std::cout << "*** Benchmarking MVC" << std::endl;

            beginAction(1, "creating views", 200, "-O0 due to compilation bug");
            create();
            endAction();

            beginAction(2, "change", items, "-O0 due to compilation bug");
            change(items);
            endAction();

            beginAction(3, "checking views", 200, "-O0 due to compilation bug");
            check(items);
            endAction();

            beginAction(4, "remove", items, "-O0 due to compilation bug");
            remove(items);
            endAction();
        }
    };
}
