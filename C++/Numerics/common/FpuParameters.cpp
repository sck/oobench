#include <iostream>

template <typename PRECISION>
class FpuParameters {
public:
    // ibeta
    int nativeRadix_;
    PRECISION nativeRadixFloat_;
    // betah
    PRECISION halfNativeRadix_;
    // betain
    PRECISION oneDivNativeRadix_;
    // it
    int digitsInMantissa_;
    // Irnd_;
    // Results: 
    //   2, 5: IEEE standard compliant rounding
    //   0, 3: Truncates not rounding
    //   Lower than xmin?
    int roundingBehavior_;
    // ngrd
    int guardDigits_;
    // machep
    int smallestPowerOfNativeRadexExp_;
    // negep
    int smallestPowerOfNativeRadixExp_;
    // iexp
    int bitsInExp_;
    int minexp_;
    int maxexp_;
    // eps
    PRECISION epsPrecision_;
    PRECISION epsnegPrecision_;
    PRECISION xmin_;
    PRECISION xmax_;
    // a
    PRECISION maxMantissa_;

    // Unknown.

    int mx_;
    int nxres_;

    // y
    PRECISION oldOdnrExpGrow_;
    // a
    PRECISION expGrowMulOne_;
    // b
    PRECISION oldOdnrPowSmallestPow_;
    // y
    PRECISION oegGrowOneDivNativeRadix_;
    // k
    int oneExpGrow_;
    // k
    int minExpCount_; 

    PRECISION epsPrecisionPlusOne_;

    // 
    PRECISION one_;
    PRECISION two_;
    PRECISION zero_;


public:

    FpuParameters() {
        // Try to fool optimizer that those values shouldn't be regarded
        // as constants, since the FPU registers may not be compatible
        // with the selected PRECISION.
        int* ip = &mx_;
        mx_ = 1;
        one_ = (PRECISION)(*ip);
        mx_ = 0;
        zero_ = (PRECISION)(*ip);
        mx_ = 2;
        two_ = (PRECISION)(*ip);
        mx_ = 0;
    }

    void maxMantissa() {
        maxMantissa_ = one_;
        PRECISION f;
        do {
            maxMantissa_ += maxMantissa_;
            PRECISION temp = maxMantissa_ + one_;
            f = temp - maxMantissa_;
        } while (f - one_ == zero_);
    }

    void nativeRadix() {
        maxMantissa();
        PRECISION b = one_;
        int i = 0;
        do {
            b += b;
            PRECISION t = maxMantissa_ + b;
            i = (int)(t - maxMantissa_) ;
        } while (i == 0);
        nativeRadix_ = i;
        nativeRadixFloat_ = (PRECISION)nativeRadix_;
    }

    void digitsInMantissa() {
        maxMantissa();
        PRECISION b = one_;
        digitsInMantissa_ = 0;
        PRECISION f;
        do {
            ++digitsInMantissa_;
            b *= nativeRadixFloat_;
            PRECISION t = b + one_;
            f = t - b;
        } while (f - one_ == zero_);
    }

    void roundingBehavior() {
        roundingBehavior_ = 0;
        // betah
        halfNativeRadix_ = nativeRadixFloat_ / two_;
        PRECISION f = maxMantissa_ + halfNativeRadix_;
        if (f - maxMantissa_ != zero_) {
            roundingBehavior_ = 1;
        }
        // tempa
        PRECISION g = maxMantissa_ + nativeRadixFloat_;
        f = g + halfNativeRadix_;
        if (roundingBehavior_ == 0 && f - g != zero_) {
            roundingBehavior_ = 2;
        }
    }

    void negepAndEpsneg() {
        smallestPowerOfNativeRadixExp_ = digitsInMantissa_ + 3;
        oneDivNativeRadix_ = one_ / nativeRadix_;
        // a
        PRECISION odnrPowSmallestPow = one_;
        for (int i = 0; i < smallestPowerOfNativeRadixExp_; ++i) {
            odnrPowSmallestPow *= oneDivNativeRadix_;
        }
        // b
        oldOdnrPowSmallestPow_ = odnrPowSmallestPow;
        // new a
        PRECISION opGrowNativeRadix = odnrPowSmallestPow;
        for (;;) {
            PRECISION f = one_ - opGrowNativeRadix;
            if (f - one_ != zero_) {
                break;
            }
            opGrowNativeRadix *= nativeRadix_;
            --smallestPowerOfNativeRadixExp_;
        }
        smallestPowerOfNativeRadixExp_ = -smallestPowerOfNativeRadixExp_;
        epsnegPrecision_ = opGrowNativeRadix;
    }

    void machepAndEps() {
        smallestPowerOfNativeRadexExp_ = -digitsInMantissa_ - 3;
        PRECISION opGrowNativeRadix = oldOdnrPowSmallestPow_;
        for (;;) {
            PRECISION f = one_ + opGrowNativeRadix;
            if (f - one_ != zero_) {
                break;
            }
            opGrowNativeRadix *= nativeRadix_;
            ++smallestPowerOfNativeRadexExp_;
        }
        epsPrecision_ = opGrowNativeRadix;
    }

    void ngrdAndIExp() {
        guardDigits_ = 0;
        PRECISION f = one_ + epsPrecision_;
        if (roundingBehavior_ == 0 && f * one_ - one_ == zero_) {
            guardDigits_ = 1;
        }
        // i
        int bitsInExpCounter = 0;
        // k
        oneExpGrow_ = 1;
        // z
        PRECISION odnrExpGrow = oneDivNativeRadix_;
        // t
        epsPrecisionPlusOne_ = one_ + epsPrecision_;
        nxres_ = 0;
        mx_ = 0;
        // y
        oldOdnrExpGrow_ = 0;
        // a
        PRECISION odnrExpGrowMulOne;
        for (;;) {
            oldOdnrExpGrow_ = odnrExpGrow;
            odnrExpGrow = oldOdnrExpGrow_ * oldOdnrExpGrow_;
            odnrExpGrowMulOne = odnrExpGrow * one_;
            // f/temp
            PRECISION expGrowMulPrecision = odnrExpGrow * epsPrecisionPlusOne_;
            if ( odnrExpGrowMulOne + odnrExpGrowMulOne == zero_ || 
                    fabs(odnrExpGrow) >= oldOdnrExpGrow_) {
                break;
            }
            PRECISION g = expGrowMulPrecision * oneDivNativeRadix_;
            if (g * nativeRadix_ == odnrExpGrow) {
                break;
            }
            ++bitsInExpCounter;
            oneExpGrow_ += oneExpGrow_;
        }
        if (nativeRadix_ != 10.0) {
            bitsInExp_ = bitsInExpCounter + 1;
            mx_ = oneExpGrow_ + oneExpGrow_;
        } else { // For decimal machines only.
            bitsInExp_ = 2;
            int nrExpGrow = nativeRadix_;
            while (oneExpGrow_ >= nrExpGrow) {
                nrExpGrow *= nativeRadix_;
                ++bitsInExp_;
            }
            mx_ = nrExpGrow + nrExpGrow - 1;
        }
    }

    void minexpAndXmin() {
        oegGrowOneDivNativeRadix_ = oldOdnrExpGrow_;
        // k
        minExpCount_ = oneExpGrow_;
        for (;;) {
            xmin_ = oldOdnrExpGrow_;
            // y / oldOdnrExpGrow_
            oegGrowOneDivNativeRadix_ *= oneDivNativeRadix_;
            // a
            expGrowMulOne_ = oegGrowOneDivNativeRadix_ * one_;
            PRECISION f = oegGrowOneDivNativeRadix_ * epsPrecisionPlusOne_;
            
            if (expGrowMulOne_ + expGrowMulOne_ != zero_ && 
                    fabs(oegGrowOneDivNativeRadix_) < xmin_) {
                ++minExpCount_;
                PRECISION g = f * oneDivNativeRadix_;
                if (g * nativeRadixFloat_ == oegGrowOneDivNativeRadix_ && 
                        f != oegGrowOneDivNativeRadix_) {
                    nxres_ = 3;
                    xmin_ = oegGrowOneDivNativeRadix_;
                    break;
                }
            } else {
                break;
            }
        }
    }

    void maxexpAndXmax() {
        minexp_ = -minExpCount_;
        if (mx_ <= minExpCount_ + minExpCount_ - 3 && nativeRadix_ != 10) {
            mx_ += mx_;
            ++bitsInExp_;
        }
        maxexp_ = mx_ + minexp_;
    }

    void adjustValues() {
        roundingBehavior_ += nxres_;
        if (roundingBehavior_ >= 2) {
            maxexp_ -= 2;
        }
        // i
        int maxExpPlusMinExp = maxexp_ + minexp_;
        // Adjust for machines with implicit leading bit in binary
        // mantissa, and machines with radix point at extreme right of
        // mantissa.
        if (nativeRadix_ == 2 && !maxExpPlusMinExp) {
            --maxexp_;
        }
        if (maxExpPlusMinExp > 20) {
            --maxexp_;
        }
        if (expGrowMulOne_ != oegGrowOneDivNativeRadix_) {
            maxexp_ -= 2;
        }
        xmax_ = one_ - epsnegPrecision_;
        if (xmax_ * one_ != xmax_) {
            xmax_ = one_ - nativeRadix_ * epsnegPrecision_;
        }
        xmax_ /= xmin_ * nativeRadix_ * nativeRadix_ * nativeRadix_;
        int maxExpPlusMinExpPlusThree = maxexp_ + minexp_ + 3;
        for (int j = 0; j < maxExpPlusMinExpPlusThree; ++j)  {
            if (nativeRadix_ == 2) {
                xmax_ += xmax_;
            } else {
                xmax_ *= nativeRadix_;
            }
        }
    }

    void calculate() {
        nativeRadix();
        digitsInMantissa();
        roundingBehavior();
        negepAndEpsneg();
        machepAndEps();
        ngrdAndIExp();
        minexpAndXmin();
        maxexpAndXmax();
        adjustValues();
    }

    void show() {
        std::cout << "sizeof type: " << sizeof(PRECISION) << std::endl;
        std::cout << "native radix (ibeta): " << nativeRadix_ << std::endl;
        std::cout << "Digits in mantissa (it): " << digitsInMantissa_ 
                << std::endl;
        std::cout << "Rounding behavior (irnd): " << 
                roundingBehavior_ << std::endl;
        if (roundingBehavior_ == 2 || roundingBehavior_ == 5) {
            std::cout << "  IEEE standard compliant rounding." <<
                    std::endl;
        }
        if (roundingBehavior_ == 1 || roundingBehavior_ == 4) {
            std::cout << "  Does rounding (not IEEE standard compliant)." <<
                    std::endl;
        }
        if (roundingBehavior_ == 0 || roundingBehavior_ == 3) {
            std::cout << "  NO rounding, truncates! (Not IEEE " << 
                "standard compliant)." << std::endl;
        }
        std::cout << "Precision (epsneg): " << epsnegPrecision_ << std::endl;
        std::cout << "Smallest power of ibeta that can be " << 
                "subtracted from 1.0 (negep): " << 
                smallestPowerOfNativeRadixExp_ << std::endl;
        std::cout << "Smallest power of ibeta that can be added " <<
                "to 1.0 (machep): " << 
                smallestPowerOfNativeRadexExp_ << std::endl;
        std::cout << "Precision (eps): " << epsPrecision_ << std::endl;
        std::cout << "Guard digits (nrgd):" << guardDigits_ << std::endl;
        std::cout << "Bits in exponent (iexp):" << bitsInExp_ << std::endl;
        std::cout << "Min exponent (minexp): " << minexp_ << std::endl;
        std::cout << "Xmin: " << xmin_ << std::endl;
        std::cout << "Max exponent (maxexp):" << maxexp_ << std::endl;
        std::cout << "Xmax:" << xmax_ << std::endl;
    }
};

template <typename PRECISION> int nativeDigitsInMantissa() {
    FpuParameters<PRECISION> p;
    p.calculate();
    static PRECISION zero = 0.0;
    static PRECISION one = 1.0;
    PRECISION b = one;
    int nativeDigitsInMantissa = 0;
    PRECISION nativeRadix = p.nativeRadixFloat_;
    do {
        ++nativeDigitsInMantissa;
        b *= nativeRadix;
    } while (((b + one) - b) - one == zero);
    return nativeDigitsInMantissa;
}

static volatile double zero() {
  return 0.0;
}

static volatile double one() {
  return 1.0;
}

static volatile double inf() {
  return one() / zero();
}

static volatile double nan() {
  return sqrt(-1);
}

void showExtremes() {
  std::cout << "log(-1): " << log(-1) << std::endl;
  std::cout << "log(-0.0): " << log(-0.0) << std::endl;
  std::cout << "log(+0.0): " << log(+0.0) << std::endl;
  std::cout << "log(nan): " << log(nan()) << std::endl;
  std::cout << "sqrt(-1): " << sqrt(-1) << std::endl;
  std::cout << "(IEEE 754 requires -0.0): sqrt(-0.0): " << 
      sqrt(-0.0) << std::endl;
  std::cout << "sqrt(+0.0): " << sqrt(+0.0) << std::endl;
  std::cout << "(IEEE 754 requires nan): sqrt(nan): " << 
      sqrt(nan()) << std::endl;
  std::cout << "1.0/0.0: " << (one() / zero()) << std::endl;
  std::cout << "1.0/-0.0: " << (one() / -zero()) << std::endl;
  std::cout << "-inf * -inf: " << (-inf() / -inf()) << std::endl;
  std::cout << "inf * -inf: " << (-inf() / inf()) << std::endl;
}

int main() {
    std::cout << "SINGLE" << std::endl;
    FpuParameters<float> ps;
    ps.calculate();
    ps.show();
    std::cout << "\nNATIVE: Digits in mantissa: " <<
            nativeDigitsInMantissa<float>() << std::endl;

    std::cout << "\nDOUBLE" << std::endl;
    FpuParameters<double> pd;
    pd.calculate();
    pd.show();
    std::cout << "\nNATIVE: Digits in mantissa: " <<
            nativeDigitsInMantissa<double>() << std::endl;

    std::cout << "\nLONG DOUBLE" << std::endl;
    FpuParameters<long double> pl;
    pl.calculate();
    pl.show();
    std::cout << "\nNATIVE: Digits in mantissa: " <<
            nativeDigitsInMantissa<long double>() << std::endl;

    std::cout << "\nSome extreme Numbers: " << std::endl;
    showExtremes();
    return 0;
}

