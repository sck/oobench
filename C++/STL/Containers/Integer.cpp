namespace oobench {

    class Integer {
    private:
        int _intValue;

    public:
        Integer(unsigned long value = 0): _intValue(value) {}
        virtual ~Integer() {}

        Integer& operator=(const Integer& i) {
            return *this;
        }

        Integer& operator=(const Integer* i) {
            return *this;
        }

        int intValue() {
            return _intValue;
        }

        bool operator< (const Integer& i2) const {
            return _intValue < i2._intValue;
        }
    };
}
