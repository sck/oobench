#include "CollectionsBenchmark.m"
@interface NSArrayPerformance : CollectionsBenchmark
@end

@implementation NSArrayPerformance

- (int)minorNumber
{
    return 1;
}

+ makeImmutableTypeOf:theId
{
    return [NSArray arrayWithArray:theId];
}

+ (void)randomAccess:theId
{
    long i;
    long count = [theId count];

    [self reset];
    for (i = 0; i < count; i++) {
        id result = [theId objectAtIndex:i];

        result = result;
        [self proceed];
    }
    [self reset];
}

@end

int main(int argc, char **argv, char **env) {
    SHOW_LOCATION("Foundation/Collections");
#if LIB_FOUNDATION_LIBRARY
    [NSProcessInfo initializeWithArguments:argv count:argc
            environment:env];
#endif
    {
        OOB_CREATE_AUTORELEASE_POOL(pool);
        NSArrayPerformance *performance = [NSArrayPerformance 
                newBenchmarkWithArguments:argc : argv];
        NSMutableArray *dict= [NSMutableArray arrayWithCapacity:500000];

        [performance test:dict items:500000];
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
