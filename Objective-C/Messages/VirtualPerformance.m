#include "MessagesBenchmark.m"
@interface VirtualPerformance:MessagesBenchmark
@end

@implementation VirtualPerformance

- (void)myVirtualOperation
{
    int foo = 10;

    foo = foo;
}

- (void)invoke:(unsigned long)count 
{
    unsigned long i;

    for (i = 0; i < count; i++) {
        [self myVirtualOperation];
    }
}

@end

int main(int argc, char **argv, char **env) {
    SHOW_LOCATION("Messages");
#if LIB_FOUNDATION_LIBRARY
    [NSProcessInfo initializeWithArguments:argv count:argc
            environment:env];
#endif
    {
        OOB_CREATE_AUTORELEASE_POOL(pool);
        VirtualPerformance *performance =
                [VirtualPerformance newBenchmarkWithArguments:argc : argv];

        [performance testWithCount:500000000 description:@"virtual"];
        OOB_RELEASE(pool);
    }
    exit(0);
    return 0;
}
