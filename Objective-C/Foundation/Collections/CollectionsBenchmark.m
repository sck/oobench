#include <Foundation/Foundation.h>
#include <sys/time.h>
#include <unistd.h>
#include "AbstractBenchmark.m"
#include "Integer.m"

#ifdef OOB_USE_AUTORELEASE_POOLS
static NSAutoreleasePool* _pool;
#endif

@interface CollectionsBenchmark : AbstractBenchmark
- (void)test:theId items:(long)items;
@end

@implementation CollectionsBenchmark

- (int)majorNumber
{
    return 1;
}

+ makeImmutableTypeOf:theId
{
    [self subclassResponsibility:_cmd];
    return nil;
}

+ (void)add:theId items:(long)items
{
    long i;

    [self reset];
#ifdef OOB_USE_AUTORELEASE_POOLS
    _pool = [[NSAutoreleasePool alloc] init];
#endif
    for (i = 0; i < items; i++) {
        Integer *integerObject = [Integer integerWithLong:rand()];

        [theId addObject:integerObject];
        [self proceed];
    }
    [self reset];
}

+ (void)iterate:theId
{
    id object;
    NSEnumerator *enumerator = [theId objectEnumerator];

    [self reset];
    while ((object = [enumerator nextObject])) {
        [self proceed];
    }
    [self reset];
}

+ (void)randomAccess:theId
{
    [self subclassResponsibility:_cmd];
}

+ (void)remove:theId
{
    [self reset];
    [theId removeAllObjects];
    OOB_RELEASE(_pool);
    [self reset];
}

- (void)test:theId items:(long)items
{
    id theImmutableId;
    items = [self countWithDefault:items];
    printf("*** Testing %s\n", [[[theId class] description] cString]);

    [self beginActionWithSubNumber:1 message:"add" count:items];
    [isa add:theId items:items];
    [self endAction];

    [self beginActionWithSubNumber:5 message:"making immutable type"
            count:items];
    theImmutableId = [isa makeImmutableTypeOf:theId];
    [self endAction];

    [self beginActionWithSubNumber:2 message:"iterate" count:items];
    [isa iterate:theId];
    [self endAction];

    [self beginActionWithSubNumber:2 message:"iterate" count:items
            comment:"immutable"];
    [isa iterate:theImmutableId];
    [self endAction];

    [self beginActionWithSubNumber:3 message:"random" count:items];
    [isa randomAccess:theId];
    [self endAction];

    [self beginActionWithSubNumber:3 message:"random" count:items
            comment:"immutable"];
    [isa randomAccess:theImmutableId];
    [self endAction];

    [self beginActionWithSubNumber:4 message:"remove" count:items
#ifdef OOB_USE_AUTORELEASE_POOLS
            comment:"includes release of autorelease pool"
#endif 
    ];

    [isa remove:theId];
    [self endAction];
}

@end
