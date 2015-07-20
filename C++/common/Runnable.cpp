namespace oobench {

    class Runnable {
    public:
        virtual void init() { }
        virtual void run() { }
        virtual void end() { }
    };
}
