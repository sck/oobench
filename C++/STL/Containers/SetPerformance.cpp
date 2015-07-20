#include <iostream>
#include <set>
#include "ContainerBenchmark.cpp"

namespace oobench {

    template<class Container, class ContainedType> 
            class SetPerformance : 
            public ContainerBenchmark<Container, ContainedType> {
    public:
        SetPerformance(int argc, const char** argv) 
                : ContainerBenchmark<Container, ContainedType>(argc, argv) { 
        }

        virtual Container& allocContainer(long items) {
            Container* theContainer = new Container();
            return (Container&) (*theContainer);
        }

        virtual int getMinorNumber() const { 
            return 4; 
        }

        virtual void add(Container& theContainer, long items)  {
            reset();
            for (long i = 0; i < items; ++i) {
                ContainedType* object = new ContainedType(
                        (unsigned long)(rand() / (float)(RAND_MAX + 1.0)) * 
                        items);
                theContainer.insert(*object);
                proceed();
            }
            reset();
        }

        virtual void iterate(Container& theContainer) {
            reset();
            typename Container::iterator p = theContainer.begin();
            while (p != theContainer.end()) {
                ContainedType value = *p;
                value = value;
                ++p;
                proceed();
            }
            reset();
        }

        void getAt(typename Container::iterator& p,
                Container& theContainer,
                long position) {
            p = theContainer.begin();
            while (p != theContainer.end() && position-- > 0) {
                ++p;
            }
        }

        virtual const char* getRandomAccessComment() {
            return "emulated";
        }

        virtual void randomAccess(Container& theContainer) {
            long size = theContainer.size();
            reset();
            typename Container::iterator p;
            for (long i = 0; i < size; ++i) {
                long position = ((long)((rand() / (float)(RAND_MAX + 1.0)) * 
                        size));
                getAt(p, theContainer, position);
                ContainedType value = *p;
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
        oobench::SetPerformance<std::set<oobench::Integer>, 
                oobench::Integer> performance(argc, argv);
        performance.test(500000L, "std::set<oobench::Integer>");
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
}
