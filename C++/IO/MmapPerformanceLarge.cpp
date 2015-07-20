#include <iostream>
#include "IOBenchmark.cpp"

#include <sys/stat.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <sys/mman.h>

namespace oobench {

    class MmapPerformanceLarge : public IOBenchmark {
    public:
        MmapPerformanceLarge(int argc, const char** argv) 
                : IOBenchmark(argc, argv) { 
        }

        virtual int getMinorNumber() const {
            return 2;
        }

        virtual void write(unsigned long count) {
            char buffer[256];
            reset();
            int out = open(".tmp.buffer", O_RDWR | O_TRUNC | O_CREAT,
                        S_IRUSR | S_IWUSR);
            if (out == -1) {
                perror(">.tmp.buffer");
                return;
            }
            //char* ram = (char*)mmap(NULL, (size_t)256 * (count + 1), 
            char* ram = (char*)mmap(NULL, 256, 
                    PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, out, 0);
            if (ram == MAP_FAILED) {
                perror("mmap ram");
                return;
            }
            memcpy(ram, &buffer, 256);
            char* p = ram;
            printf("ram = 0x%08x\n", (unsigned)ram);
            printf("p = 0x%08x\n", (unsigned)p);
            for (unsigned long i = 0; i < count; ++i, p += 256) {
                printf("%lu\n", i);
                printf("p = 0x%08x\n", (unsigned)p);
                memcpy(p, &buffer, 256);
                proceed();
            }
            if (munmap(ram, 256) == -1) {
                perror("munmap");
                return;
            }
            close(out);
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
                char* ram = (char*)mmap(0, 256, 
                        PROT_READ, MAP_FILE | MAP_PRIVATE, in, 0);
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
                if (out == -1) {
                    perror(">.tmp.buffer");
                    break;
                }
                char* ram = (char*)mmap(NULL, 256, PROT_READ | PROT_WRITE, 
                        MAP_SHARED, out, 0);
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
                if (in == -1) {
                    perror(".tmp.buffer");
                }
                ram = (char*)mmap(NULL, 256, PROT_READ, MAP_SHARED, in, 0);
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
        oobench::MmapPerformanceLarge performance(argc, argv);
        performance.test(50000L, "UNIX mmap");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
