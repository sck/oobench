#include "CollectionsBenchmark.m"
@interface NSSetPerformance : CollectionsBenchmark
@end

@implementation NSSetPerformance

- (int)minorNumber
{
    return 4;
}

+ makeImmutableTypeOf:theId
{
    return [NSSet setWithSet:theId];
}

+ (void)randomAccess:theId
{
    Integer *integerObject = [Integer integerWithLong:0];
    long i;
    long count = [theId count];

    [self reset];
    for (i = 0; i < count; i++) {
        BOOL result = [theId containsObject:[integerObject setLongValue:i]];

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
        NSSetPerformance *performance = [NSSetPerformance 
                newBenchmarkWithArguments:argc : argv];
        NSMutableSet *set= [NSMutableSet setWithCapacity:500000];

        [performance test:set items:500000];
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
