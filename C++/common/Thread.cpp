#include <pthread.h>

namespace oobench {

    class Thread;
    static void* _thread_start(void* threadDataP);

    typedef struct {
        Thread* threadInstance;
    } thread_data_t;

    class ThreadException {
        const char* aMessage;
    public:
        ThreadException(const char* theMessage) {
            aMessage = theMessage;
        }

        const char* message() {
            return aMessage;
        }
    };

    class Thread {
    private:
        Runnable* runnable;
        pthread_t threadId;
        thread_data_t* threadData;

    public: 
        Thread(Runnable* theRunnable) : runnable(theRunnable) {
            if (runnable != 0) {
                runnable->init();
            }
            threadData = (thread_data_t*)malloc(sizeof(thread_data_t));
            threadData->threadInstance = this;
        }

        virtual ~Thread() {
            free(threadData);
        }

        Runnable* getRunnable() const {
            return runnable;
        }

        pthread_t getThreadId() const {
            return threadId;
        }

        void start() {
            int error = pthread_create(&threadId, NULL, _thread_start, 
                    (void*)threadData);
            if (error) {
                throw ThreadException(strerror(error));
            }
        }

        void join() {
            int error = pthread_join(threadId, NULL);
            if (error) {
                throw ThreadException(strerror(error));
            }
        }

    };

    static void* _thread_start(void* threadDataP) {
        thread_data_t* threadData = (thread_data_t*)threadDataP;
        threadData->threadInstance->getRunnable()->run();
        pthread_exit(NULL);
        return 0; /* NOT REACHED */
    }
}
