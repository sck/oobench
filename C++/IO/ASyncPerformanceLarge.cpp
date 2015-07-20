#include <iostream>
#include "IOBenchmark.cpp"

#include "async.h"

namespace oobench {

    class ASyncPerformanceLarge : public IOBenchmark {
    public:
        ASyncPerformanceLarge(int argc, const char** argv) 
                : IOBenchmark(argc, argv) { 
        }

        virtual int getMinorNumber() const {
            return 2;
        }

        virtual void write(unsigned long count) {
            char buffer[256];
            reset();
            int out = open(".tmp.buffer", O_WRONLY | O_TRUNC | O_CREAT,
                        S_IRUSR | S_IWUSR);
            if (out == -1) {
                perror(">.tmp.buffer");
            }
            if (fcntl(out, F_SETFL, IO_ASYNC) == -1) {
                perror("failed to set async I/O mode");
                return;
            }
            if (out == -1) {
                perror(">.tmp.buffer");
                return;
            }
            for (unsigned long i = 0; i < count; ++i) {
                if (::write(out, &buffer, 256) == -1) {
                    perror("write");
                    break;
                }
                proceed();
            }
            close(out);
            reset();
        }

        virtual void read(unsigned long count) {
            char buffer[256];
            reset();
            int in = open(".tmp.buffer", O_RDONLY);
            if (in == -1) {
                perror(".tmp.buffer");
            }
            if (fcntl(in, F_SETFL, IO_ASYNC) == -1) {
                perror("failed to set async I/O mode");
                return;
            }
            if (in == -1) {
                perror(".tmp.buffer");
                return;
            }
            for (unsigned long i = 0; i < count; ++i) {
                if (::read(in, &buffer, 256) == -1) {
                    perror("read");
                }
                proceed();
            }
            close(in);
            reset();
        }

        virtual void writeAndRead(unsigned long count) {
            char buffer[256];
            reset();
            int out = open(".tmp.buffer", O_WRONLY | O_TRUNC | O_CREAT,
                        S_IRUSR | S_IWUSR);
            if (out == -1) {
                perror(">.tmp.buffer");
            }
            if (fcntl(out, F_SETFL, IO_ASYNC) == -1) {
                perror("failed to set async I/O mode");
                return;
            }
            if (out == -1) {
                perror(">.tmp.buffer");
                return;
            }
            for (unsigned long i = 0; i < count / 2; ++i) {
                if (::write(out, &buffer, 256) == -1) {
                    perror("write");
                    break;
                }
                proceed();
            }
            close(out);
            int in = open(".tmp.buffer", O_RDONLY);
            if (in == -1) {
                perror(".tmp.buffer");
            }
            if (fcntl(in, F_SETFL, IO_ASYNC) == -1) {
                perror("failed to set async I/O mode");
                return;
            }
            if (in == -1) {
                perror(".tmp.buffer");
                return;
            }
            for (unsigned long i = 0; i < count / 2; ++i) {
                if (::read(in, &buffer, 256) == -1) {
                    perror("read");
                    break;
                }
                proceed();
            }
            close(in);
            reset();
        }
    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("IO");
    try {
        oobench::ASyncPerformanceLarge performance(argc, argv);
        performance.test(50000L, "UNIX I/O, async");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
