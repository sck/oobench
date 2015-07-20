#include "AlgorithmBenchmark.cpp"
#include <iterator>

namespace oobench {

    std::string makeRand() {
        std::ostringstream oss;
        oss << ((double)(RAND_MAX + 1.0) * 2000000);
        return oss.str();
    }

    void doNothing(std::string& s) {
    }

    std::string addBang(std::string &s) {
        return s + '!';
    }

    template<class Container>
            class AlgorithmPerformance : public AlgorithmBenchmark {
    public:
        AlgorithmPerformance(int argc, const char** argv) 
                : AlgorithmBenchmark(argc, argv) { 
        }

        virtual int getMinorNumber() const {
            return 3;
        }

        void generateRandom(Container& c, long count) {
            size_t size = c.size();
            c.resize(size + count);
            std::generate_n(c.begin() + size, count, makeRand);
        }

        void forEach(Container& c, long repetitions) {
            reset();
            for (long i = 0; i < repetitions; ++i) {
                std::for_each(c.begin(), c.end(), doNothing);
                proceed();
            }
            reset();
        }

        void findRandom(Container& c, long repetitions) {
            reset();
            for (long i = 0; i < repetitions; ++i) {
                typename Container::iterator result = 
                        std::find(c.begin(), c.end(),
                        c[(int)(rand() / 
                        (float)(RAND_MAX + 1.0) * (c.size() - 1))]);
                result = result;
                proceed();
            }
            reset();
        }

        void countRandom(Container& c, long repetitions) {
            reset();
            for (long i = 0; i < repetitions; ++i) {
                int result = std::count(c.begin(), c.end(), 
                        c[(int)(rand() / 
                        (float)(RAND_MAX + 1.0) * (c.size() - 1))]);
                result = result; 
                proceed();
            }
            reset();
        }

        void equalItself(Container& c, long repetitions) {
            reset();
            for (long i = 0; i < repetitions; ++i) {
                std::equal(c.begin(), c.end(), c.begin());
                proceed();
            }
            reset();
        }

        void searchRandomItself(Container& c, long repetitions) {
            reset();
            for (long i = 0; i < repetitions; ++i) {
                int startAt = (int)(rand() / 
                        (float)(RAND_MAX + 1.0) * (c.size() - 2));
                int size = (int)(rand() / (float)(RAND_MAX + 1.0) * 
                        (c.size() - startAt - 1));
                typename Container::iterator result = 
                        std::search(c.begin(), c.end(), 
                        c.begin() + startAt, c.begin() + startAt + size);
                result = result;
                proceed();
            }
            reset();
        }

        void copyItself(Container& c, long repetitions) {
            reset();
            Container tmp(c.size());
            for (long i = 0; i < repetitions; ++i) {
                std::copy(c.begin(), c.end(), tmp.begin());
                proceed();
            }
            reset();
        }

        void transformData(Container& c, long repetitions) {
            reset();
            Container tmp(c.size());
            for (long i = 0; i < repetitions; ++i) {
                std::transform(c.begin(), c.end(), tmp.begin(), addBang);
                proceed();
            }
            reset();
        }

        void copySort(Container& c, long repetitions) {
            reset();
            Container tmp(c.size());
            for (long i = 0; i < repetitions; ++i) {
                std::copy(c.begin(), c.end(), tmp.begin());
                std::sort(tmp.begin(), tmp.end());
                proceed();
            }
            reset();
        }

        void copyStableSort(Container& c, long repetitions) {
            reset();
            Container tmp(c.size());
            for (long i = 0; i < repetitions; ++i) {
                std::copy(c.begin(), c.end(), tmp.begin());
                std::stable_sort(tmp.begin(), tmp.end());
                proceed();
            }
            reset();
        }

        void uniqueCopy(Container& c, long repetitions) {
            reset();
            Container tmp(c.size());
            for (long i = 0; i < repetitions; ++i) {
                std::unique_copy(c.begin(), c.end(), tmp.begin());
                proceed();
            }
            reset();
        }

        void replaceCopyRandom(Container& c, long repetitions) {
            reset();
            Container tmp(c.size());
            for (long i = 0; i < repetitions; ++i) {
                std::replace_copy(c.begin(), c.end(), tmp.begin(),
                        c[(int)(rand() / (float)(RAND_MAX + 1.0) * 
                        (c.size() - 1))], (std::string)"bad");
                proceed();
            }
            reset();
        }

        void removeCopyRandom(Container& c, long repetitions) {
            reset();
            Container tmp(c.size());
            for (long i = 0; i < repetitions; ++i) {
                std::remove_copy(c.begin(), c.end(), tmp.begin(),
                        c[(int)(rand() / (float)(RAND_MAX + 1.0) * 
                        (c.size() - 1))]);
                proceed();
            }
            reset();
        }

        void reverseCopy(Container& c, long repetitions) {
            reset();
            Container tmp(c.size());
            for (long i = 0; i < repetitions; ++i) {
                std::reverse_copy(c.begin(), c.end(), tmp.begin());
                proceed();
            }
            reset();
        }

        void swapRandom(Container& c, long count) {
            reset();
            Container tmp(c.size());
            std::copy(c.begin(), c.end(), tmp.begin());
            for (long i = 0; i < count; ++i) {
                int pos = (int)(rand() / (float)(RAND_MAX + 1.0) * 
                        (c.size() - 2));
                std::swap(tmp[pos], tmp[pos + 1]);
                proceed();
            }
            reset();
        }


        void copySortBinarySearchRandom(Container& c, long count) {
            reset();
            Container tmp(c.size());
            std::copy(c.begin(), c.end(), tmp.begin());
            std::sort(tmp.begin(), tmp.end());
            proceed();
            for (long i = 0; i < count; ++i) {
                bool result = 
                    std::binary_search(tmp.begin(), tmp.end(),
                            tmp[(int)(rand() / (float)(RAND_MAX + 1.0) * 
                            (c.size() - 1))]);
                result = result;
                proceed();
            }
            reset();
        }

        void copySortMerge(Container& c) {
            reset();
            Container tmp(c.size());
            Container tmp2(c.size());
            std::copy(c.begin(), c.end(), tmp.begin());
            std::sort(tmp.begin(), tmp.end());
            proceed();
            std::copy(c.begin(), c.end(), tmp2.begin());
            std::sort(tmp2.begin(), tmp2.end());
            proceed();

            Container result(c.size() * 2);
            std::merge(tmp.begin(), tmp.end(),
                    tmp2.begin(), tmp2.end(), result.begin());
        }

        void show(Container& c) {
            std::copy(c.begin(), c.end(),
                    std::ostream_iterator<std::string>(std::cout, "\n"));
        }

        void test(long count) {
            count = getCountWithDefault(count);
            long repetitions = 5;
            std::cout << "*** Benchmarking ISO C++ Algorithms with " << 
                "std::vector<std::string>" << std::endl;
            Container& data = *(new Container());

            beginAction(1, "generate random data", count);
            generateRandom(data, count);
            endAction();

            beginAction(2, "for_each all elements", repetitions);
            forEach(data, repetitions);
            endAction();

            beginAction(3, "find random elements", 500);
            findRandom(data, 500);
            endAction();

            beginAction(4, "count random elements", repetitions);
            countRandom(data, repetitions);
            endAction();

            beginAction(5, "equal against itself", repetitions);
            equalItself(data, repetitions);
            endAction();

            beginAction(6, "search random sequences of elements", repetitions);
            searchRandomItself(data, repetitions);
            endAction();

            beginAction(7, "copy all elements", repetitions);
            copyItself(data, repetitions);
            endAction();

            beginAction(8, "transform all elements", repetitions);
            transformData(data, repetitions);
            endAction();

            beginAction(9, "copy, and sort all elements", repetitions);
            copySort(data, repetitions);
            endAction();

            beginAction(10, "copy, and stable_sort all elements", repetitions);
            copyStableSort(data, repetitions);
            endAction();

            beginAction(11, "unique_copy all elements", repetitions);
            uniqueCopy(data, repetitions);
            endAction();

            beginAction(12, "replace_copy with random elements", repetitions);
            replaceCopyRandom(data, repetitions);
            endAction();

            beginAction(13, "remove_copy with random elements", repetitions);
            removeCopyRandom(data, repetitions);
            endAction();

            beginAction(14, "reverse_copy all elements", repetitions);
            reverseCopy(data, repetitions);
            endAction();

            beginAction(15, "swap random elements", count);
            swapRandom(data, count);
            endAction();

            beginAction(16, "copy, sort, and binary_search random elements", 
                    500);
            copySortBinarySearchRandom(data, 500);
            endAction();

            beginAction(17, "2 x copy, and sort, thereafter merge all "
                    "elements", 1);
            copySortMerge(data);
            endAction();
        }
    };
}

int main(int argc, const char** argv) {
    SHOW_LOCATION("STL/Algorithms");
    try {
        oobench::AlgorithmPerformance<std::vector<std::string> > 
                performance(argc, argv);
        performance.test(500000L);
    } catch (...) {
        std::cerr << "Unknown exception caught" << std::endl;
    }
    return 0;
    std::exit(0);
}
