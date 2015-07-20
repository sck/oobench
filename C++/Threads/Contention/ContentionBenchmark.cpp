#include "AbstractBenchmark.cpp"
#include "Runnable.cpp"
#include "Thread.cpp"

namespace oobench {

#define logMax  1048576

    static char threadLogData[logMax];
    long logCount = 0;

    class ProgressShower;

    class ContentionBenchmark : public Runnable, 
            public AbstractBenchmark {

        int id;
        
    public:
        ContentionBenchmark(int argc, const char** argv) 
                : AbstractBenchmark(argc, argv) { 
        }

        ContentionBenchmark() { }

        ContentionBenchmark(int theId) {
            id = theId;
        }

        virtual int getMajorNumber() const {
            return 7;
        }

        void threadIsActive() {
            if (logCount < logMax) {
                threadLogData[logCount++] = id;
            }
        }

        static long getLogCount() {
            return logCount;
        }

        static bool isDone() {
            return logCount >= logMax;
        }

        int getId() const {
            return id;
        }

        int evalLog() {
            long changes = 0;
            int oldValue = threadLogData[0];
            for (long i = 0; i < logMax; ++i) {
                if (oldValue != threadLogData[i]) {
                    oldValue = threadLogData[i];
                    ++changes;
                }
            }

            int percent = 0;
            if (changes > 0) {
                percent = (100 / logMax) * changes;
            }
            return percent;
        }
    };

    class ProgressShower : public ContentionBenchmark {

    public:
        ProgressShower() { }

        virtual int getMinorNumber() const {
            return 0;
        }

        virtual void run () {
            while (!isDone()) {
                std::ostringstream oss;
                oss.width(8);
                oss << getLogCount() << "\b\b\b\b\b\b\b\b";
                std::cout << oss.str() << std::flush;
                sleep(1);
            }
        }
    };
}
