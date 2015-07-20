#include <Foundation/Foundation.h>
#include "ArchivingBenchmark.m"
#include "ArchiveClassSimple.m"

@interface ArchivingPerformanceSimple : ArchivingBenchmark
@end

@implementation ArchivingPerformanceSimple
@end

int main(int argc, char **argv, char **env) {
    SHOW_LOCATION("Foundation/Archiving");
#if LIB_FOUNDATION_LIBRARY
    [NSProcessInfo initializeWithArguments:argv count:argc
            environment:env];
#endif
    {
        OOB_CREATE_AUTORELEASE_POOL(pool);
        ArchivingPerformanceSimple *performance =
                [ArchivingPerformanceSimple 
                newBenchmarkWithArguments:argc : argv];
                
        [performance testWithCount:50000 class:[ArchiveClassSimple class]
                description:@"simple archiving" minorNumber:1];
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
