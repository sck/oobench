#include "AbstractBenchmark.cpp"

namespace oobench {

    class IPCBenchmark : public AbstractBenchmark {
    public:
        IPCBenchmark(int argc, const char** argv) 
                : AbstractBenchmark(argc, argv) { 
        }

        virtual void write(unsigned long count) = 0;
        virtual void read(unsigned long count) = 0;
        virtual void writeAndRead(unsigned long count) = 0;

        void test(unsigned long count, const char* description) {
            /*
             * 1. Create two threads.
             * 2. Let thema communicate and measure time.
             */
        }
    };
}
