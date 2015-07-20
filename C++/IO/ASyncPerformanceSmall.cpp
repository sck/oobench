#include <iostream>
#include "IOBenchmark.cpp"

#include "async.h"

namespace oobench {

    class ASyncPerformanceSmall : public IOBenchmark {
    public:
        ASyncPerformanceSmall(int argc, const char** argv) 
                : IOBenchmark(argc, argv) { 
        }

        virtual int getMinorNumber() const {
            return 1;
        }

        virtual void write(unsigned long count) {
            char buffer[256];
            reset();
            for (unsigned long i = 0; i < count; ++i) {
                int out = open(".tmp.buffer", O_WRONLY | O_TRUNC | O_CREAT,
                        S_IRUSR | S_IWUSR);
                if (out == -1) {
                    perror(">.tmp.buffer");
                }
                if (fcntl(out, F_SETFL, IO_ASYNC) == -1) {
                    perror("failed to set async I/O mode");
                    break;
                }
                if (out == -1) {
                    perror(">.tmp.buffer");
                    break;
                }
                if (::write(out, &buffer, 256) == -1) {
                    perror("write");
                    break;
                }
                close(out);
                proceed();
            }
            reset();
        }

        virtual void read(unsigned long count) {
            char buffer[256];
            reset();
            for (unsigned long i = 0; i < count; ++i) {
                int in = open(".tmp.buffer", O_RDONLY);
                if (in == -1) {
                    perror(".tmp.buffer");
                }
                if (fcntl(in, F_SETFL, IO_ASYNC) == -1) {
                    perror("failed to set async I/O mode");
                    break;
                }
                if (in == -1) {
                    perror(".tmp.buffer");
                    break;
                }
                if (::read(in, &buffer, 256) == -1) {
                    perror("read");
                }
                close(in);
                proceed();
            }
            reset();
        }

        virtual void writeAndRead(unsigned long count) {
            char buffer[256];
            reset();
            for (unsigned long i = 0; i < count; ++i) {
                int out = open(".tmp.buffer", O_WRONLY | O_TRUNC | O_CREAT,
                        S_IRUSR | S_IWUSR);
                if (out == -1) {
                    perror(">.tmp.buffer");
                }
                if (fcntl(out, F_SETFL, IO_ASYNC) == -1) {
                    perror("failed to set async I/O mode");
                    break;
                }
                if (out == -1) {
                    perror(">.tmp.buffer");
                    break;
                }
                if (::write(out, &buffer, 256) == -1) {
                    perror("write");
                    break;
                }
                close(out);
                int in = open(".tmp.buffer", O_RDONLY);
                if (in == -1) {
                    perror(".tmp.buffer");
                }
                if (fcntl(in, F_SETFL, IO_ASYNC) == -1) {
                    perror("failed to set async I/O mode");
                    break;
                }
                if (in == -1) {
                    perror(".tmp.buffer");
                    break;
                }
                if (::read(in, &buffer, 256) == -1) {
                    perror("read");
                    break;
                }
                close(in);
                proceed();
            }
            reset();
        }
    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("IO");
    try {
        oobench::ASyncPerformanceSmall performance(argc, argv);
        performance.test(50000L, "UNIX I/O functions, async");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
