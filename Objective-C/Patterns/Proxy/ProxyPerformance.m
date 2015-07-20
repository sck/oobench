#include <Foundation/Foundation.h>
#include "AbstractBenchmark.m"
#include "Proxy.m"
#include "Data.m"

@interface ProxyPerformance : AbstractBenchmark
- (void)testWithCount:(long)count;
- (void)invokeWithProxyWithCount:(int)count;
- (void)invokeWithoutProxyWithCount:(int)count;
@end

@implementation ProxyPerformance

- (int)majorNumber
{
    return 8;
}

- (int)minorNumber
{
    return 2;
}

- (void)invokeWithProxyWithCount:(int)count
{
    long i;
    id dataPointer = [Proxy proxyWithObject:[Data data]];

    [isa reset];
    for (i = 0; i < count; i++) {
        if ([dataPointer size] != 1234) {
            fprintf(stderr, "Error: operation 'size' did not return the "
                    "expected value (1234)!\n");
            break;
        }
    }
    [isa reset];
}

- (void)invokeWithoutProxyWithCount:(int)count
{
    long i;
    id data = [Data data];

    [isa reset];
    for (i = 0; i < count; i++) {
        if ([data size] != 1234) {
            fprintf(stderr, "Error: operation 'size' did not return the "
                    "expected value (1234)!\n");
            break;
        }
    }
    [isa reset];
}

- (void)testWithCount:(long)count
{
    count = [self countWithDefault:count];
    printf("*** Benchmarking Generic Proxy\n");

    [self beginActionWithSubNumber:1 message:"method call" count:count
            comment:"full dynamic proxy"];
    [self invokeWithProxyWithCount:count];
    [self endAction];

    [self beginActionWithSubNumber:2 message:"method call, without proxy" 
            count:count];
    [self invokeWithoutProxyWithCount:count];
    [self endAction];
}
@end

int main(int argc, char **argv, char **env) {
    SHOW_LOCATION("Patterns/Proxy");
#if LIB_FOUNDATION_LIBRARY
    [NSProcessInfo initializeWithArguments:argv count:argc
            environment:env];
#endif  
    {
        OOB_CREATE_AUTORELEASE_POOL(pool);
        ProxyPerformance *performance =
                [ProxyPerformance newBenchmarkWithArguments:argc : argv];

        [performance testWithCount:500000l];
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
