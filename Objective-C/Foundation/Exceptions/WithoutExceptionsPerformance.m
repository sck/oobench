#include <Foundation/Foundation.h>
#include "ExceptionsBenchmark.m"

@interface WithoutExceptionsPerformance: ExceptionsBenchmark
@end

@implementation WithoutExceptionsPerformance

- (int)minorNumber
{
    return 1;
}

+ (int)simpleException
{
    return 1;
}

+ (void)exceptWithCount:(unsigned long)count
{
    unsigned long i = 0;

    for (i = 0; i < count; i++) {
        if ([self simpleException] == 1) {
        }
    }
}

+ (int)deepException2
{
    return 3;
}

+ (int)deepException
{
    long result = [self deepException2];

    if (1 == result) {
        return 0;
    } else if (2 == result) {
        return 0;
    }
    return result;
}

+ (void)exceptDeepWithCount:(unsigned long)count
{
    unsigned long i = 0;

    for (i = 0; i < count; i++) {
        if ([self deepException] > 0) {
        }
    }
}

@end

int main(int argc, char **argv, char **env) {
    SHOW_LOCATION("Foundation/Exceptions");
#if LIB_FOUNDATION_LIBRARY
    [NSProcessInfo initializeWithArguments:argv count:argc
            environment:env];
#endif
    {
        OOB_CREATE_AUTORELEASE_POOL(pool);
        WithoutExceptionsPerformance *performance =
                [WithoutExceptionsPerformance 
                newBenchmarkWithArguments:argc : argv];

        [performance testWithCount:500000 description:@"without exceptions"];
        OOB_RELEASE(pool);
    }
    exit(0);
    return 0;
}
