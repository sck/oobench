#include <Foundation/Foundation.h>
#include "config.h"
#include "oob_memory.h"
#include <sys/time.h>
#include "Memory.m"
#include "Stopwatch.m"

#define SHOW_LOCATION(dir) \
        printf("Location: Objective-C/%s/%s\n", dir, __FILE__)

@interface AbstractBenchmark : NSObject
long internalCount;
long refreshCounter;
long watermark;
BOOL smallScale;
long memoryAtBegin;
Stopwatch *timer;

char *_back = "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b";
NSString *back = nil;
char *_space = "                    ";
NSString *space = nil;
NSMutableArray *arguments = nil;
struct timeval then;
BOOL slow;
BOOL accurate = YES;
BOOL testOnly = NO;

+ newBenchmark;
+ newBenchmarkWithArguments:(int)argc : (char **)argv;
- init;
- initWithArguments:(int)argc : (char **)argv;
+ (void)reset;
+ (void)proceed;
+ (long)proceedSmallScaleAllowedAndSize:(long)size;
+ (NSString *)beautifyBytes:(long)byteCount;
- (long)countWithDefault:(long)count;
- (void)beginActionWithSubNumber:(int)subNumber 
        message:(const char *)message count:(long)count
        comment:(const char *)comment;
- (void)beginActionWithSubNumber:(int)subNumber 
        message:(const char *)message count:(long)count;
- (void)endAction;
#ifdef MACOSX_FOUNDATION
- subclassResponsibility:(id)anId;
+ subclassResponsibility:(id)anId;
#endif
@end

@implementation AbstractBenchmark
+ newBenchmark
{
    return OOB_AUTORELEASE([[self alloc] init]);
}

+ newBenchmarkWithArguments:(int)argc : (char **)argv 
{
    return [[self alloc] initWithArguments:argc : argv];
}

- init 
{
    [super init];
    timer = [Stopwatch stopwatch];
    return self;
}

- initWithArguments:(int)argc : (char **)argv 
{
    int i;

    [self init];
    arguments = [NSMutableArray array];
    for (i = 0; i < argc; i++) {
        NSString *argument = [NSString stringWithCString: argv[i]];
        [arguments addObject: argument];
    }

    accurate = ![arguments containsObject:@"-p"];
    if (!accurate) {
        printf("Play mode, don't take results too serious.\n");
    }
    testOnly = [arguments containsObject:@"-t"];
    if (testOnly) {
        printf("Tests only.\n");
    }
    return self;
}

+ (void)reset
{
    slow = !accurate;
    if (accurate) {
        return;
    }
    if (space == nil) {
        space = [NSString stringWithCString:_space];
    }
    if (back == nil) {
        back = [NSString stringWithCString:_back];
    }
    if (internalCount > 0) {
        NSString *s = [NSString stringWithFormat:@"%ld", internalCount];

        printf("%s%s", [[space substringToIndex:[s length] + 1] cString], 
                [[back substringToIndex:[s length] + 1] cString]);
    }
    internalCount = 0;
    refreshCounter = 0;
    gettimeofday(&then, NULL);
    watermark = 99;
}

+ (long)_proceedWithSmallScaleAllowed:(BOOL)smallScaleAllowed 
        andSize:(long)size
{
    if (accurate) {
        if (smallScaleAllowed && !smallScale) {
            smallScale = YES;
            return size / 5000;
        }
        return size;
    } else {
        struct timeval now;

        memcpy(&now, &then, sizeof(then));
        internalCount++;
        refreshCounter++;
        if (slow) {
            gettimeofday(&now, NULL);
            if (now.tv_sec == then.tv_sec && 
                    (now.tv_usec - then.tv_usec) < 5000) {
                slow = NO;
                watermark = 9999;
            }
        }
        if (slow || refreshCounter > watermark) {
            NSString *s = [NSString stringWithFormat:@"%ld%c",
                    internalCount, (slow ? 's' : 'f')];

            refreshCounter = 0;
            memcpy(&now, &then, sizeof(then));
            printf([s cString]);
            printf([[back substringToIndex:[s length]] cString]);
            fflush(stdout);
        }
    }
    if (smallScaleAllowed && !smallScale && slow ) {
        smallScale = YES;
        return size / 5000;
    }
    return size;
}

+ (void)proceed
{
    [self _proceedWithSmallScaleAllowed:NO andSize:0];
}

+ (long)proceedSmallScaleAllowedAndSize:(long)size
{
    return [self _proceedWithSmallScaleAllowed:YES andSize:size];
}

#ifdef MACOSX_FOUNDATION
- subclassResponsibility:(id)anId
{
}
+ subclassResponsibility:(id)anId
{
}
#endif

- (int)majorNumber
{
    [self subclassResponsibility:_cmd];
    return 0;
}

- (int)minorNumber
{
    [self subclassResponsibility:_cmd];
    return 0;
}

- (void)beginActionWithSubNumber:(int)subNumber 
        message:(const char *)message count:(long)count
        comment:(const char *)comment
{
    memoryAtBegin = [Memory usedMemory];
    printf("ObjC: [%d.%d.%d] %s (%ld)", 
            [self majorNumber], [self minorNumber], 
            subNumber, message, count);
    if (strcmp(comment, "") != 0) {
        printf(" -- %s", comment);
    }
    printf(": ");
    fflush(stdout);
    [[timer reset] start];
    smallScale = NO;
}

- (void)beginActionWithSubNumber:(int)subNumber 
        message:(const char *)message count:(long)count
{
    [self beginActionWithSubNumber:subNumber message:message 
            count:count comment:""];
}

- (void)endAction
{
    [timer stop];
    if (smallScale) {
        printf("%lde ms (%s+?)\n", [timer getElapsedTime] * 5000,
                [[isa beautifyBytes:[Memory usedMemory] - memoryAtBegin] 
                cString]);
    } else {
        printf("%ld ms (%s)\n", [timer getElapsedTime],
                [[isa beautifyBytes:[Memory usedMemory] - memoryAtBegin] 
                cString]);
    }
    smallScale = NO;
}

+ (NSString *)beautifyBytes:(long)byteCount
{
    NSArray *measure = [NSArray arrayWithObjects:
            @"B", @"KB", @"M", @"GB", @"TB", nil];
    long m = 0;
    float f = (float)byteCount;

    while (f > 1024) {
        m++;
        f /= 1024;
    }
    while (f < -1024) {
        m++;
        f /= 1024;
    }
    return [NSString stringWithFormat:@"%.2f %@", f, [measure objectAtIndex:m]];
}

- (long)countWithDefault:(long)count
{
    return testOnly ? 1 : count;
}

@end
