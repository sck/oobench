#include "AbstractBenchmark.cpp"
#include "Flyweight.hpp"

namespace oobench {

    class FlyweightPerformance : public AbstractBenchmark {
        Bitmap* bitmap;
        Screen* screen;
    public:
        FlyweightPerformance(int argc, const char** argv) 
                : AbstractBenchmark(argc, argv) {
        }

        virtual int getMajorNumber() const {
            return 8;
        }

        virtual int getMinorNumber() const {
            return 3;
        }

        void create() {
            screen = new Screen(2000000);
            bitmap = new Bitmap(*screen);
        }

        void draw(unsigned long count) {
            reset();
            for (unsigned long i = 0; i < count; ++i) {
                bitmap->show();
                proceed();
            }
            reset();
        }

        void drawWithoutFlyweight(unsigned long count) {
            reset();
            for (unsigned long i = 0; i < count; ++i) {
                bitmap->showWithoutFlyweight();
                proceed();
            }
            reset();
        }

        void remove() {
            delete bitmap;
            delete screen;
        }

        void test(unsigned long count) {
            count = getCountWithDefault(count);
            std::cout << "*** Benchmarking Flyweight" << std::endl;

            beginAction(1, "creating screen/bitmap, 2000000 pixel", 1);
            create();
            endAction();

            beginAction(2, "drawing to virtual screen", count);
            draw(count);
            endAction();

            beginAction(2, "drawing to virtual screen", count,
                    "using screen directly, avoiding context");
            drawWithoutFlyweight(count);
            endAction();

            beginAction(4, "removing bitmap/screen", 1);
            remove();
            endAction();
        }
    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("Patterns/Flyweight");
    try {
        oobench::FlyweightPerformance performance(argc, argv);
        performance.test(20L);
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    std::exit(0);
    return 0;
}
