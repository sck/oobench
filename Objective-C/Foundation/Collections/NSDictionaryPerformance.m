#include "CollectionsBenchmark.m"
@interface NSDictionaryPerformance : CollectionsBenchmark
@end

@implementation NSDictionaryPerformance

- (int)minorNumber
{
    return 3;
}

+ makeImmutableTypeOf:theId
{
    return [NSDictionary dictionaryWithDictionary:theId];
}

+ (void)add:theId items:(long)items
{
    long i;

    [self reset];
    for (i = 0; i < items; i++) {
        Integer *integerObject = [Integer integerWithLong:(long)rand()];

        [theId setObject:integerObject forKey:integerObject];
        [self proceed];
    }
    [self reset];
}

+ (void)iterate:theId
{
    id value;
    id key;
    NSEnumerator *enumerator = [theId keyEnumerator];

    [self reset];
    while ((key = [enumerator nextObject])) {
        value = [theId objectForKey:key];
        [self proceed];
    }
    [self reset];
}

+ (void)randomAccess:theId
{
    Integer *integerObject = [Integer integerWithLong:0];
    long i;
    long count = [theId count];

    [self reset];
    for (i = 0; i < count; i++) {
        id result = [theId objectForKey:[integerObject 
                setLongValue:(long)((float)(rand() / 
                (RAND_MAX + 1.0)) * count)]];

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
        NSDictionaryPerformance *performance = [NSDictionaryPerformance 
                newBenchmarkWithArguments:argc : argv];
        NSMutableDictionary *dict= [NSMutableDictionary new];

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
