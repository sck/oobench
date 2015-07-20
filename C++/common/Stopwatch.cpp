/*
 *  This class originated from the book: "Java(TM) Platform Performance -- 
 *  Strategies and Tactics", by Steve Wilson and Jeff Kesselman,
 *  published by Addison-Wesley.
 */

#ifdef __UNIX__
#include <sys/time.h>
#endif

#ifdef __WINDOWS__
#include <windows.h>
#define sleep(ms) ::Sleep(ms * 1000)
#endif

namespace oobench {

    class Stopwatch {
        private:

        long startTime;
        long stopTime;
        bool running;

    public:
        Stopwatch::Stopwatch() {
            startTime = -1;
            stopTime = -1;
            running = false;
        }

        unsigned long currentTimeMillis() {
            unsigned long result = 0;
#ifdef __UNIX__
            struct timeval now;
            gettimeofday(&now, NULL);
            result = now.tv_sec * 1000 + (now.tv_usec / 1000); 
            return result;
#endif
#ifdef __WINDOWS__
            SYSTEMTIME t;
            GetLocalTime(&t);
            result = 3600000 * t.wHour + 60000 * t.wMinute + 
                1000 * t.wSecond + t.wMilliseconds;

#endif
            return result;
        }

        Stopwatch& start() {
            startTime = currentTimeMillis();
            running = true;
            return *this;
        }

        Stopwatch& stop() {
            stopTime = currentTimeMillis();
            running = false;
            return *this;
        }

        unsigned long getElapsedTime() {
            if (startTime == -1) {
                return 0;
            }
            if (running) {
                long now = currentTimeMillis();
                return now - startTime;
            } else {
                return stopTime - startTime;
            }
        }

        Stopwatch& reset() {
            startTime = -1;
            stopTime = -1;
            running = false;
            return *this;
        }
    };
}
