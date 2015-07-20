#include "AbstractBenchmark.m"

@interface MVCBenchmark : AbstractBenchmark
- (void)testWithCount:(unsigned long)items;
@end

@implementation MVCBenchmark

- (int)majorNumber
{
    return 8;
}

- (int)minorNumber
{
    return 1;
}

- (void)create
{
    [self subclassResponsibility:_cmd];
}

- (void)change:(unsigned long)items
{
    [self subclassResponsibility:_cmd];
}

- (void)check:(unsigned long)items
{
    [self subclassResponsibility:_cmd];
}

- (void)remove:(unsigned long)items
{
    [self subclassResponsibility:_cmd];
}

- (void)testWithCount:(unsigned long)items
{
    items = [self countWithDefault:items];

    printf("*** Benchmarking MVC\n");

    [self beginActionWithSubNumber:1 message:"creating views" count:200];
    [self create];
    [self endAction];

    [self beginActionWithSubNumber:2 message:"change" count:items];
    [self change:items];
    [self endAction];

    [self beginActionWithSubNumber:3 message:"checking views" count:200];
    [self check:items];
    [self endAction];

    [self beginActionWithSubNumber:4 message:"remove" count:items];
    [self remove:items];
    [self endAction];
}

@end
