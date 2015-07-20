#include <iostream>
#include "IOBenchmark.cpp"

namespace oobench {

    class AnsiPerformanceLarge : public IOBenchmark {
    public:
        AnsiPerformanceLarge(int argc, const char** argv) 
                : IOBenchmark(argc, argv) { 
        }

        virtual int getMinorNumber() const {
            return 2;
        }

        virtual void write(unsigned long count) {
            char buffer[256];
            reset();
            FILE* out = fopen(".tmp.buffer", "w");
            if (out == NULL) {
                perror(".tmp.buffer");
                return;
            }
            for (unsigned long i = 0; i < count; ++i) {
                if (fwrite(&buffer, 1, 256, out) < 256) {
                    perror("fwrite");
                    break;
                }
                proceed();
            }
            fclose(out);
            reset();
        }

        virtual void read(unsigned long count) {
            char buffer[256];
            reset();
            FILE* in = fopen(".tmp.buffer", "r");
            if (in == NULL) {
                perror(".tmp.buffer");
                return;
            }
            for (unsigned long i = 0; i < count; ++i) {
                if (fread(&buffer, 1, 256, in) < 256) {
                    perror("fread");
                    break;
                }
                proceed();
            }
            fclose(in);
            reset();
        }

        virtual void writeAndRead(unsigned long count) {
            char buffer[256];
            reset();
            FILE* out = fopen(".tmp.buffer", "w");
            if (out == NULL) {
                perror(">.tmp.buffer");
                return;
            }
            for (unsigned long i = 0; i < count / 2; ++i) {
                if (fwrite(&buffer, 1, 256, out) < 256) {
                    perror("fwrite");
                    break;
                }
                proceed();
            }
            fclose(out);
            FILE* in = fopen(".tmp.buffer", "r");
            if (in == NULL) {
                perror(".tmp.buffer");
                return;
            }
            for (unsigned long i = 0; i < count / 2; ++i) {
                if (fread(&buffer, 1, 256, in) < 256) {
                    perror("fread");
                    break;
                }
                proceed();
            }
            fclose(in);
            reset();
        }
    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("IO");
    try {
        oobench::AnsiPerformanceLarge performance(argc, argv);
        performance.test(50000L, "ANSI C I/O");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
