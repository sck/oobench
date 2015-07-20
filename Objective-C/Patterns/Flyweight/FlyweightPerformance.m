#import <Foundation/Foundation.h>
#import "AbstractBenchmark.m"

#import "Screen.m"
#import "DrawContext.m"
#import "PixelPoint.m"
#import "Bitmap.m"

#define SCREEN_SIZE 2000000

@interface FlyweightPerformance : AbstractBenchmark
{
    Bitmap *bitmap;
    Screen *screen;
}
@end

@implementation FlyweightPerformance

- (int)majorNumber
{
    return 8;
}

- (int)minorNumber
{
    return 3;
}

- (void)create
{
    screen = OOB_RETAIN([Screen screenWithSize:SCREEN_SIZE]);
    bitmap = OOB_RETAIN([Bitmap bitmapWithScreen:screen]);
}

- (void)drawWithCount:(int)count
{
    int i;

    [isa reset];
    for (i = 0; i < count; i++) {
        [bitmap show];
        [isa proceed];
    }
    [isa reset];
}

- (void)remove
{
    OOB_RELEASE(bitmap);
    OOB_RELEASE(screen);
}

- (void)testWithCount:(unsigned long)count
{
    count = [self countWithDefault:count];
    printf("*** Benchmarking Flyweight\n");

    [self beginActionWithSubNumber:1 
            message:"creating screen/bitmap, 2000000 pixel" count:1];
    [self create];
    [self endAction];

    [self beginActionWithSubNumber:2 
            message:"drawing to virtual screen" count:count];
    [self drawWithCount:count];
    [self endAction];

    [self beginActionWithSubNumber:4 
            message:"removing bitmap/screen" count:1];
    [self remove];
    [self endAction];
}

@end


int main(int argc, char **argv, char **env) {
    SHOW_LOCATION("Patterns/Flyweight");
#if LIB_FOUNDATION_LIBRARY
    [NSProcessInfo initializeWithArguments:argv count:argc
            environment:env];
#endif  
    {
        OOB_CREATE_AUTORELEASE_POOL(pool);
        FlyweightPerformance *performance =
                [FlyweightPerformance newBenchmarkWithArguments:argc : argv];
        [performance testWithCount:20L];
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
