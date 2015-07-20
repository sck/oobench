#include "ColorsModel.hpp"
#include "ColorsController.hpp"
#include "DumbColorsView.cpp"
#include "MVCBenchmark.cpp"
#include "InvalidRgbFormatException.hpp"

namespace oobench {

    struct DrawCountException { };

    class CheckViews {
        unsigned long items;
    public:
        explicit CheckViews(unsigned long theItems): items(theItems) { }
        void operator()(DumbColorsView* view) {
            if (view->getDrawCount() != items) {
                throw DrawCountException();
            }
        }
    };

    class MVCPerformance : public MVCBenchmark {
        ColorsModel* theModel;
        std::list<DumbColorsView*> views;
        unsigned long itemCount;
    public:
        MVCPerformance(int argc, const char** argv) 
                : MVCBenchmark(argc, argv) {
        }

        virtual void create() {
            theModel = new ColorsModel();
            char number[1024];
            for (unsigned long i = 0; i < 200; ++i) {
                // XXX: Use stringstream! (available as of GCC-3.0.0)
                sprintf(number, "%ld", i);
                DumbColorsView* view = 
                        new DumbColorsView(*theModel, (char*)&number);
                views.push_back(view);
            }
        }

        virtual void change(unsigned long items) {
            ColorsController controller = views.front()->getColorsController();
            char colorName[1024];
            char rgbValue[1024];
            reset();
            for (unsigned long i = 0; i < items; ++i) {
                // XXX: Use stringstream! (available as of GCC-3.0.0)
                sprintf(colorName, "x%ld", i);
                sprintf(rgbValue, "#%ld", i);
                controller.addColor(colorName, rgbValue);
                proceed();
            }
            reset();
        }

        virtual void check(unsigned long items) {
            try {
                for_each(views.begin(), views.end(), CheckViews(items));
            } catch (DrawCountException& dce) {
                std::cerr << "Warning: Draw count didn't match!" << std::endl;
            }
        }

        virtual void remove(unsigned long items) {
            reset();
            views.clear();
            delete theModel;
            reset();
        }
    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("Patterns/MVC");
    try {
        oobench::MVCPerformance performance(argc, argv);
        performance.test(50000L);
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    std::exit(0);
    return 0;
}
