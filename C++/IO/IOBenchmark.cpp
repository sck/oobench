#include "AbstractBenchmark.cpp"

namespace oobench {

    class IOBenchmark : public AbstractBenchmark {
    public:
        IOBenchmark(int argc, const char** argv) 
                : AbstractBenchmark(argc, argv) { 
        }

        virtual int getMajorNumber() const {
            return 4;
        }

        virtual void write(unsigned long count) = 0;
        virtual void read(unsigned long count) = 0;
        virtual void writeAndRead(unsigned long count) = 0;

        void test(unsigned long items, const char* description) {
            unsigned long count = getCountWithDefault(items);
            std::cout << "*** Testing I/O (" << description << ")" << std::endl;
            
            beginAction(1, "write", count, description);
            write(count);
            endAction();

            beginAction(2, "read", count, description);
            read(count);
            endAction();

            beginAction(3, "writeAndRead", count, description);
            writeAndRead(count);
            endAction();
        }
    };
}
