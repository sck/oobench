#include <Foundation/Foundation.h>
#include <sys/time.h>
#include <unistd.h>
#include "AbstractBenchmark.m"

@interface MessagesBenchmark: AbstractBenchmark
- (void)testWithCount:(unsigned long)count description:(NSString *)description;
@end

@implementation MessagesBenchmark

- (int)majorNumber
{
    return 5;
}

- (int)minorNumber
{
    return 1;
}

- (void)invoke:(unsigned long)count 
{
    [self subclassResponsibility:_cmd];
}

- (void)testWithCount:(unsigned long)count description:(NSString *)description
{
    count = [self countWithDefault: count];
    [self beginActionWithSubNumber:1 message:"invoke" count:count
            comment:[description cString]];
    [self invoke:count];
    [self endAction];
}

@end
