#include <iostream>
#include "IOBenchmark.cpp"

namespace oobench {

    class AnsiPerformanceSmall : public IOBenchmark {
    public:
        AnsiPerformanceSmall(int argc, const char** argv) 
                : IOBenchmark(argc, argv) { 
        }

        virtual int getMinorNumber() const {
            return 1;
        }

        virtual void write(unsigned long count) {
            char buffer[256];
            reset();
            for (unsigned long i = 0; i < count; ++i) {
                FILE* out = fopen(".tmp.buffer", "w");
                if (out == NULL) {
                    perror(".tmp.buffer");
                    break;
                }
                if (fwrite(&buffer, 1, 256, out) < 256) {
                    perror("fwrite");
                    break;
                }
                fclose(out);
                proceed();
            }
            reset();
        }

        virtual void read(unsigned long count) {
            char buffer[256];
            reset();
            for (unsigned long i = 0; i < count; ++i) {
                FILE* in = fopen(".tmp.buffer", "r");
                if (in == NULL) {
                    perror(".tmp.buffer");
                    break;
                }
                if (fread(&buffer, 1, 256, in) < 256) {
                    perror("fread");
                    break;
                }
                fclose(in);
                proceed();
            }
            reset();
        }

        virtual void writeAndRead(unsigned long count) {
            char buffer[256];
            reset();
            for (unsigned long i = 0; i < count; ++i) {
                FILE* out = fopen(".tmp.buffer", "w");
                if (out == NULL) {
                    perror(">.tmp.buffer");
                    break;
                }
                if (fwrite(&buffer, 1, 256, out) < 256) {
                    perror("fwrite");
                    break;
                }
                fclose(out);
                FILE* in = fopen(".tmp.buffer", "r");
                if (in == NULL) {
                    perror(".tmp.buffer");
                    break;
                }
                if (fread(&buffer, 1, 256, in) < 256) {
                    perror("fread");
                    break;
                }
                fclose(in);
                proceed();
            }
            reset();
        }
    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("IO");
    try {
        oobench::AnsiPerformanceSmall performance(argc, argv);
        performance.test(50000L, "ANSI C I/O");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
