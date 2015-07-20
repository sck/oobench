#include <Foundation/Foundation.h>
#include <sys/time.h>
#include <unistd.h>
#include "AbstractBenchmark.m"
#include "../Integer.m"

@interface SortBenchmark : AbstractBenchmark
- (void)testWithCount:(long)items description:(NSString *)description;
@end

@implementation SortBenchmark

- (int)majorNumber
{
    return 9;
}

+ (void)sort:(NSMutableArray *)theArray
{
    [self subclassResponsibility:_cmd];
}

- (void)testWithCount:(long)items description:(NSString *)description
{
    long i = 0;
    NSMutableArray *theArray= [NSMutableArray array];
    items = [self countWithDefault:items];

    printf("*** Creating array with random values\n");
    for (i = 0; i < items; i++) {
        [theArray addObject:[Integer 
                integerWithLong:(long)((rand() / 
                (float)(RAND_MAX + 1.0)) * items)]];
    }
    printf("*** Testing %s\n", [description cString]);

    [self beginActionWithSubNumber:1 message:"sort" count:items];
    [isa sort:theArray];
    [self endAction];
}

@end
