#ifdef __UNIX__
#include <sys/time.h>
#endif
#include <cstdio>
#ifdef __UNIX__
#include <unistd.h>
#endif
#include "Stopwatch.cpp"

#ifdef __WINDOWS__
#define sbrk int
#endif

#include <algorithm>
#include <string>
#include <vector>
#include <iostream>
#include <sstream>

#define SHOW_LOCATION(dir) std::cout << "Location: C++/" << dir << \
       "/" <<  __FILE__ << std::endl

namespace oobench {

    class AbstractBenchmark {
        long internalCount;
        long refreshCounter;
        long watermark;
        bool accurate;
        bool testOnly;
        bool slow;
        bool smallScale;
        Stopwatch timer;
        char* memoryAtBegin;

        std::string back;
        std::string space;
#ifdef __UNIX__
        struct timeval then;
#endif

        std::vector<std::string> arguments;

        void init() {
            accurate = true;
            internalCount = 0;
            back = "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b";
            space = "                    ";
            arguments.clear();
        }

        void init(int argc, const char** argv) {
            init();
            for (int i = 0; i < argc; ++i) {
                arguments.push_back(argv[i]);
            }
            accurate = !(find(arguments.begin(), arguments.end(), "-p") != 
                    arguments.end());
            if (!accurate) {
                std::cout << "Play mode, don't take results too serious." << 
                        std::endl;
            }
            testOnly = (find(arguments.begin(), arguments.end(), "-t") !=
                    arguments.end());
            if (testOnly) {
                std::cout << "Tests only." << std::endl;
            }
        }

        long _proceed(bool smallScaleAllowed, long size) {
            if (accurate) {
                if (smallScaleAllowed && !smallScale) {
                    smallScale = true;
                    return size / 5000;
                }
                return size;
            }
#ifdef __UNIX__
            struct timeval now;
            memcpy(&now, &then, sizeof(then));
            ++internalCount;
            ++refreshCounter;
            if (slow) {
                gettimeofday(&now, NULL);
                if (now.tv_sec == then.tv_sec && 
                        (now.tv_usec - then.tv_usec) < 5000) {
                    slow = false;
                    watermark = 9999;
                }
            }
            if (slow || refreshCounter > watermark) {
                std::ostringstream oss;
                oss << internalCount << (slow ? 's' : 'f');
                std::string s = oss.str();
                refreshCounter = 0;
                memcpy(&now, &then, sizeof(then));
                std::cout << s << back.substr(0, s.length()) << std::flush;
            }
            if (smallScaleAllowed && !smallScale && slow ) {
                smallScale = true;
                return size / 5000;
            }
#endif
            return size;
        }

    public:

        AbstractBenchmark() { 
            init();
        }

        AbstractBenchmark(int argc, const char** argv) {
            init(argc, argv);
        }

        virtual ~AbstractBenchmark() { }

        void reset() {
            slow = !accurate;
            if (accurate) {
                return;
            }
            if (internalCount > 0) {
                std::ostringstream oss;
                oss << internalCount;
                std::string s = oss.str();
                std::cout << space.substr(0, s.length() + 1) << 
                        back.substr(0, s.length() + 1) << std::flush;
            }
#ifdef __UNIX__
            internalCount = 0;
            refreshCounter = 0;
            gettimeofday(&then, NULL);
            watermark = 99;
#endif
        }

        void proceed() {
            _proceed(false, 0);
        }

        long proceedSmallScaleAllowed(long size) {
            return _proceed(true, size);
        }

        virtual int getMajorNumber() const = 0;
        virtual int getMinorNumber() const = 0;

        void beginAction(int subNumber, const char* message, long count,
                const char* comment = "") {
            memoryAtBegin = (char*)sbrk(0);
            std::cout << "C++: [" << getMajorNumber() << "." <<
                    getMinorNumber() << "." << subNumber << "] " << 
                    message << " (" << count << ")";
            if (strcmp(comment, "") != 0) {
                std::cout << " -- "  << comment;
            }
            std::cout << ": " << std::flush;
            timer.reset().start();
            smallScale = false;
        }

        void endAction() {
            std::string beautifiedBytes;
            timer.stop();
            beautifyBytes(beautifiedBytes, (char*)sbrk(0) - memoryAtBegin);
            if (smallScale) {
                std::cout << (unsigned long) timer.getElapsedTime() * 5000 <<
                        "e ms (" << beautifiedBytes << "+?)" << std::endl;
            } else {
                std::cout << (unsigned long) timer.getElapsedTime() <<
                        " ms (" << beautifiedBytes << ")" << std::endl;
            }
            smallScale = false;
        }

        void beautifyBytes(std::string& result, long byteCount) {
            const char* measure[] = {"B", "KB", "M", "GB", "TB"};
            long m = 0;
            float f = (float)byteCount;
            while (f > 1024) {
                ++m;
                f /= 1024;
            }
            while (f < -1024) {
                ++m;
                f /= 1024;
            }
            std::ostringstream oss;
            oss.precision(2);
            oss << f << " " << measure[m];
            result = oss.str();
        }

        long getCountWithDefault(long count) {
            return testOnly ? 1 : count;
        }
    };
}
