#include <Foundation/Foundation.h>
#include "AbstractBenchmark.m"

@interface ArchivingBenchmark : AbstractBenchmark
int _minorNumber;
- (void)testWithCount:(unsigned long)count class:theClass 
        description:(NSString *)description minorNumber:(int)theMinorNumber;
@end

@implementation ArchivingBenchmark

- (int)majorNumber
{
    return 10;
}

- (int)minorNumber
{
    return _minorNumber;
}

+ (void)archiveWithClass:theClass andCount:(unsigned long)count 
{
    NSString *tempFile = @".tmp.archive";
    unsigned long i;

    [self reset];
    for (i = 0; i < count; i++) {
        OOB_CREATE_AUTORELEASE_POOL(pool);
        id theInstance = [theClass new];

        if (![NSArchiver archiveRootObject:theInstance toFile:tempFile]) {
            fprintf(stderr, "archiveRootObject:toFile: failed!\n");
        } else {
            theInstance = [NSUnarchiver unarchiveObjectWithFile:tempFile];
            if (theInstance == nil) {
                fprintf(stderr, "unarchiveObjectWithFile: failed!\n");
            }
        }
        OOB_RELEASE(pool);
        [self proceed];
    }
    [self reset];
}

- (void)testWithCount:(unsigned long)count class:theClass 
        description:(NSString *)description minorNumber:(int)theMinorNumber
{
    _minorNumber = theMinorNumber;
    count = [self countWithDefault:count];
    printf("*** Testing %s\n", [description cString]);

    [self beginActionWithSubNumber:1 message:"persistence write/read"
            count:count];
    [isa archiveWithClass:theClass andCount:count];
    [self endAction];
}

@end
