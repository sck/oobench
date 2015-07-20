#include <Foundation/Foundation.h>
#include "SortBenchmark.m"

@interface SortingWithSelectorPerformance : SortBenchmark
@end

@implementation SortingWithSelectorPerformance

- (int)minorNumber
{
    return 7;
}

+ (void)sort:(NSMutableArray *)theArray
{
    [theArray sortUsingSelector:@selector(compare:)];
}
@end

int main(int argc, char **argv, char **env) {
    SHOW_LOCATION("Foundation/Collections/Sorting");
#if LIB_FOUNDATION_LIBRARY
    [NSProcessInfo initializeWithArguments:argv count:argc
            environment:env];
#endif
    {
        OOB_CREATE_AUTORELEASE_POOL(pool);
        SortingWithSelectorPerformance *performance =
                [SortingWithSelectorPerformance 
                newBenchmarkWithArguments:argc : argv];

        [performance testWithCount:50000 description:@"sorting using selector"];
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
