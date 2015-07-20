#include <sys/time.h>
/*
 *  This class originated from the book: "Java(TM) Platform Performance -- 
 *  Strategies and Tactics", by Steve Wilson and Jeff Kesselman,
 *  published by Addison-Wesley.
 */

@interface Stopwatch:NSObject
{
    long startTime;
    long stopTime;
    BOOL running;
}
+ (long)currentTimeMillis;
+ stopwatch;
- init;
- start;
- stop;
- (long)getElapsedTime;
- reset;
@end

@implementation Stopwatch: NSObject

+ stopwatch
{
    return OOB_AUTORELEASE([[self alloc] init]);
}

- init 
{
    [super init];
    startTime = -1;
    stopTime = -1;
    running = NO;
    return self;
}

+ (long)currentTimeMillis
{
    struct timeval now;
    long result;

    gettimeofday(&now, NULL);
    result = now.tv_sec * 1000 + (now.tv_usec / 1000); 
    return result;
}

- start 
{
    startTime = [isa currentTimeMillis];
    running = YES;
    return self;
}

- stop 
{
    stopTime = [isa currentTimeMillis];
    running = NO;
    return self;
}

- (long)getElapsedTime
{
    if (startTime == -1) {
        return 0;
    }
    if (running) {
        long now = [isa currentTimeMillis];

        return now - startTime;
    } else {
        return stopTime - startTime;
    }
}

- reset
{
    startTime = -1;
    stopTime = -1;
    running = NO;
    return self;
}

@end
