#include <Foundation/Foundation.h>
#include "ExceptionsBenchmark.m"

@interface ExceptionClass1 : NSException
@end

@implementation ExceptionClass1 
@end

@interface ExceptionClass2 : NSException
@end

@implementation ExceptionClass2 
@end

@interface ExceptionClass3 : NSException
@end

@implementation ExceptionClass3 
@end

@interface ExceptionsPerformance: ExceptionsBenchmark
@end

@implementation ExceptionsPerformance

- (int)minorNumber
{
    return 2;
}

+ (void)simpleException
{
    THROW([ExceptionClass1 alloc]);
}

unsigned long i = 0;

+ (void)exceptWithCount:(unsigned long)count
{
    for (i = 0; i < count; i++) {
        TRY {
            [self simpleException];
        } END_TRY
        CATCH(ExceptionClass1) {
            OOB_RELEASE(localException);
        } END_CATCH
    }
}

+ (void)deepException2
{
    THROW([ExceptionClass3 alloc]);
}

+ (void)deepException
{
    TRY {
        [self deepException2];
    } END_TRY
    MULTICATCH([ExceptionClass1 class], [ExceptionClass2 class]) {
        OOB_RELEASE(localException);
    } END_CATCH
}

+ (void)exceptDeepWithCount:(unsigned long)count
{
    for (i = 0; i < count; i++) {
        TRY {
            [self deepException];
        } END_TRY
        OTHERWISE {
            OOB_RELEASE(localException);
        } END_CATCH
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
        ExceptionsPerformance *performance =
                [ExceptionsPerformance newBenchmarkWithArguments:argc : argv];

        [performance testWithCount:500000 description:@"exceptions"];
#ifdef OOB_USE_AUTORELEASE_POOLS
        {
            Stopwatch *timer = [[Stopwatch alloc] init];

            [timer start];
            printf("autoreleasing: ");
            fflush(stdout);
            OOB_RELEASE(pool);
            [timer stop];
            printf("%ld ms\n", [timer getElapsedTime]);
            OOB_RELEASE(timer);
        }
#endif
    }
    exit(0);
    return 0;
}
