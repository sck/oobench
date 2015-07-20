#include <Foundation/Foundation.h>
#include "ArchivingBenchmark.m"

@interface ArchivingPerformance : ArchivingBenchmark
@end

@implementation ArchivingPerformance

+ (void)archiveWithCount:(unsigned long)count
{
}

@end

int main(int argc, char **argv, char **env) {
    SHOW_LOCATION("Foundation/Archiving");
#if LIB_FOUNDATION_LIBRARY
    [NSProcessInfo initializeWithArguments:argv count:argc
            environment:env];
#endif
    {
        OOB_CREATE_AUTORELEASE_POOL(pool);
        ArchivingPerformance *performance =
                [ArchivingPerformance newBenchmarkWithArguments:argc : argv];

        [performance testWithCount:500000 description:@"archiving" 
                minorNumber:2];
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
