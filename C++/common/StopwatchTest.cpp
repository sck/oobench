#include <iostream>
#ifdef __UNIX__
#include <unistd.h>
#endif
#include "Stopwatch.cpp"

int main(int argc, const char** argv) {
    try {
        oobench::Stopwatch timer;

        timer.reset().start();
        std::cout << "Sleeping ..." << std::endl;
        sleep(4);
        timer.stop();
        std::cout << "Elapsed time: " << timer.getElapsedTime() << "ms" <<
                std::endl;
        int i;
        for (i = 0; i < 99; ++i) {
            std::cout << timer.currentTimeMillis() << std::endl;
            for (int jj = 0; jj < 9999; ++jj) {
            }
        }
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
}
