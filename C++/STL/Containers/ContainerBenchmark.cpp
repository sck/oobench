#include "AbstractBenchmark.cpp"
#include "Integer.cpp"

namespace oobench {

    template<typename Container, typename ContainedType> 
            class ContainerBenchmark : public AbstractBenchmark {
    public:
        ContainerBenchmark(int argc, const char** argv) 
                : AbstractBenchmark(argc, argv) { 
        }

        virtual Container& allocContainer(long items) = 0;

        virtual void add(Container& theContainer, long items) = 0;
        virtual void iterate(Container& theContainer) = 0;
        virtual void randomAccess(Container& theContainer) = 0;
        virtual void remove(Container& theContainer) = 0;

        virtual int getMajorNumber() const {
            return 1;
        }

        virtual const char* getRandomAccessComment() {
            return "";
        }

        virtual const char* getRemoveComment() {
            return "";
        }

        void test(long items, const char* className) {
            long count = getCountWithDefault(items);
            Container& theContainer = allocContainer(count);

            std::cout << "*** Testing " << className << std::endl;
            beginAction(1, "add", count);
            add(theContainer, count);
            endAction();

            beginAction(2, "iterate", count);
            iterate(theContainer);
            endAction();

            beginAction(3, "random", count, getRandomAccessComment());
            randomAccess(theContainer);
            endAction();

            beginAction(4, "remove", count, getRemoveComment());
            remove(theContainer);
            endAction();
        }
    };
}
