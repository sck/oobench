#include <iostream>
#include <vector>
#include "ContainerBenchmark.cpp"

namespace oobench {

    template<class Container, class ContainedType> 
            class VectorPerformance : 
            public ContainerBenchmark<Container, ContainedType> {
    public:

        VectorPerformance(int argc, const char** argv) 
                : ContainerBenchmark<Container, ContainedType>(argc, argv) { 
        }

        virtual Container& allocContainer(long items) {
            Container* theContainer = new Container(items);
            return (Container&) (*theContainer);
        }

        virtual int getMinorNumber() const {
            return 1;
        }

        virtual void add(Container& theContainer, long items)  {
            reset();
            for (long i = 0; i < items; ++i) {
                theContainer[i] = new ContainedType(
                        (unsigned long)(rand() / (RAND_MAX + 1.0)) * items);
                proceed();
            }
            reset();
        }

        virtual void iterate(Container& theContainer) {
            long size = (long)theContainer.size();
            reset();
            for (long i = 0; i < size; ++i) {
                ContainedType value = theContainer[i];
                value = value;
                proceed();
            }
            reset();
        }

        virtual void randomAccess(Container& theContainer) {
            long size = theContainer.size();
            reset();
            for (long i = 0; i < size; ++i) {
                ContainedType value = 
                        theContainer[((long)(rand() / (RAND_MAX + 1.0)) * 
                        size)];
                value = value;
                proceed();
            }
            reset();
        }

        virtual void remove(Container& theContainer) {
            reset();
            theContainer.clear();
            reset();
        }
    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("STL/Containers");
    try {
        oobench::VectorPerformance<std::vector<oobench::Integer>, 
                oobench::Integer> performance(argc, argv);
        performance.test(500000L, "std::vector<oobench::Integer>");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
