#include <iostream>
#include <vector>
#include "ContentionBenchmark.cpp"

namespace oobench {

    class ThreadSwitchPerformance : public ContentionBenchmark {
        std::vector<Thread*> *threads;
    public:
        ThreadSwitchPerformance(int argc, const char** argv) 
                : ContentionBenchmark(argc, argv) { 
        }

        ThreadSwitchPerformance(int theId) : ContentionBenchmark(theId) { 
        }

        virtual int getMinorNumber() const {
            return 1;
        }
        
        virtual void run() {
            while (!isDone()) {
                threadIsActive();
                threadIsActive();
                threadIsActive();
                threadIsActive();
                threadIsActive();
                threadIsActive();
                threadIsActive();
                threadIsActive();
                threadIsActive();
                for (long i = 0; i < 100000; ++i) {
                    ; 
                }
            }
        }

        void test(long items) {
            long count = getCountWithDefault(items);
            threads = new std::vector<Thread*>(count);
            std::cout << "*** Testing thread switching performance" 
                    << std::endl;
            std::cout << "thread switching (" << count << " threads): " << 
                    std::endl;
            std::cout << "  creating threads..." << std::flush;
            for (long i = 0; i < count; ++i) {
                ThreadSwitchPerformance* performance = 
                        new ThreadSwitchPerformance(i);
                try {
                    (*threads)[i] = new Thread(performance);
                } catch (ThreadException& te)  {
                    std::cerr << "Exception: " << te.message() << std::endl;
                }
            }
            std::cout << std::endl;
            std::cout << "  starting threads..." << std::flush;
            for (long i = 0; i < count; ++i) {
                try {
                    (*threads)[i]->start();
                } catch (ThreadException& te)  {
                    std::cerr << "Exception: " << te.message() << std::endl;
                }
            }
            std::cout << std::endl;
            std::cout << "  waiting for threads ..." << std::flush;
            Thread *progress = new Thread(new ProgressShower());
            progress->start();
            for (long i = 0; i < count; ++i) {
                try {
                    (*threads)[i]->join();
                } catch (ThreadException& te)  {
                    std::cerr << "Exception: " << te.message() << std::endl;
                }
            }
            progress->join();
            delete progress;
            std::cout << std::endl;
            std::cout << "  result: " << evalLog() << "%" << std::endl;
        }
    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("Threads");
    try {
        oobench::ThreadSwitchPerformance performance(0);
        performance.test(10L);
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
