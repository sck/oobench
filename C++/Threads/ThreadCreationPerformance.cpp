#include "AbstractBenchmark.cpp"
#include "Runnable.cpp"
#include "Thread.cpp"

namespace oobench {

    class ThreadCreationPerformance : public Runnable, 
            public AbstractBenchmark {
    public:
        ThreadCreationPerformance() { 
        }

        ThreadCreationPerformance(int argc, const char** argv) 
                : AbstractBenchmark(argc, argv) { 
        }

        virtual int getMajorNumber() const {
            return 6;
        }

        virtual int getMinorNumber() const {
            return 1;
        }

        virtual void run() {
            std::cout << "";
        }

        void test(long items) {
            long count = getCountWithDefault(items);
            std::cout << "*** Testing thread creation performance" 
                    << std::endl;
            
            beginAction(1, "thread creation", count);
            reset();
            ThreadCreationPerformance* performance = 
                    new ThreadCreationPerformance();
            for (long i = 0; i < count; ++i) {
                try {
                    Thread* thread = new Thread(performance);
                    thread->start();
                    thread->join();
                    delete thread;
                    proceed();
                } catch (ThreadException& te)  {
                    std::cerr << "Exception: " << te.message() << std::endl;
                }
            }
            delete performance;
            reset();
            endAction();
        }
    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("Threads");
    try {
        oobench::ThreadCreationPerformance performance(argc, argv);
        performance.test(20000L);
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
