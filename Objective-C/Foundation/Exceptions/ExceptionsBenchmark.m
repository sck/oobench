#include <Foundation/Foundation.h>
#include "AbstractBenchmark.m"


@interface ExceptionsBenchmark: AbstractBenchmark
- (void)testWithCount:(unsigned long)count description:(NSString *)description;
@end

@implementation ExceptionsBenchmark

- (int)majorNumber
{
    return 3;
}

+ (void)exceptWithCount:(unsigned long)count
{
    [self subclassResponsibility:_cmd];
}

+ (void)exceptDeepWithCount:(unsigned long)count
{
    [self subclassResponsibility:_cmd];
}

- (void)testWithCount:(unsigned long)count description:(NSString *)description
{
    count = [self countWithDefault:count];

    printf("*** Testing %s\n", [description cString]);
    [self beginActionWithSubNumber:1 message:"except" count:count];
    [isa exceptWithCount:count];
    [self endAction];
    
    [self beginActionWithSubNumber:2 message:"except deep" count:count];
    [isa exceptDeepWithCount:count];
    [self endAction];
}

@end
