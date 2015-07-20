#include <iostream>
#include "IOBenchmark.cpp"

#include <sys/stat.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <sys/mman.h>

namespace oobench {

    class MmapPerformanceSmall : public IOBenchmark {
    public:
        MmapPerformanceSmall(int argc, const char** argv) 
                : IOBenchmark(argc, argv) { 
        }

        virtual int getMinorNumber() const {
            return 1;
        }

        virtual void write(unsigned long count) {
            char buffer[256];
            reset();
            for (unsigned long i = 0; i < count; ++i) {
                int out = open(".tmp.buffer", O_RDWR | O_TRUNC | O_CREAT,
                        S_IRUSR | S_IWUSR);
                if (out < 0) {
                    perror(">.tmp.buffer");
                    break;
                }
                char* ram = (char*)mmap(NULL, 256, PROT_READ | PROT_WRITE, 
                        MAP_PRIVATE, out, 0);
                if (ram == MAP_FAILED) {
                    perror("mmap ram");
                    break;
                }
                memcpy(ram, &buffer, 256);
                if (munmap(ram, 256) == -1) {
                    perror("munmap");
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
                if (in < 0) {
                    perror(".tmp.buffer");
                }
                char* ram = (char*)mmap(NULL, 256, PROT_READ, MAP_PRIVATE, in, 0);
                if (ram == MAP_FAILED) {
                    perror("mmap ram");
                    break;
                }
                memcpy(&buffer, ram, 256);
                if (munmap(ram, 256) == -1) {
                    perror("munmap");
                    break;
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
                int out = open(".tmp.buffer", O_RDWR | O_TRUNC | O_CREAT,
                        S_IRUSR | S_IWUSR);
                if (out < 0) {
                    perror(">.tmp.buffer");
                    break;
                }
                char* ram = (char*)mmap(NULL, 256, PROT_READ | PROT_WRITE, 
                        MAP_PRIVATE, out, 0);
                if (ram == MAP_FAILED) {
                    perror("mmap ram");
                    break;
                }
                memcpy(ram, &buffer, 256);
                if (munmap(ram, 256) == -1) {
                    perror("munmap");
                    break;
                }
                close(out);
                int in = open(".tmp.buffer", O_RDONLY);
                if (in < 0) {
                    perror(".tmp.buffer");
                }
                ram = (char*)mmap(NULL, 256, PROT_READ, MAP_PRIVATE, in, 0);
                if (ram == MAP_FAILED) {
                    perror("mmap ram");
                    break;
                }
                memcpy(&buffer, ram, 256);
                if (munmap(ram, 256) == -1) {
                    perror("munmap");
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
        oobench::MmapPerformanceSmall performance(argc, argv);
        performance.test(50000L, "UNIX mmap");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
