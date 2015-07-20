#include <Foundation/Foundation.h>
#import "ColorsModel.h"
#import "ColorsController.h"
#import "DumbColorsView.h"
#import "MVCBenchmark.m"
#import "InvalidRgbFormatException.h"

@interface MVCPerformance : MVCBenchmark
{
    ColorsModel *theModel;
    NSMutableArray *views;
    unsigned long itemCount;
}
@end

@implementation MVCPerformance

- init
{
    [super init];
    views = OOB_RETAIN([NSMutableArray array]);
    return self;
}

- (void)create
{
    char number[1024];
    unsigned long i;

    theModel = [ColorsModel model];
    for (i = 0; i < 200; i++) {
        DumbColorsView* view;

        sprintf(number, "%ld", i);
        view = [DumbColorsView viewWithModel:theModel andName:(char*)&number];
        [views addObject:view];
    }
}

- (void)change:(unsigned long)items
{
    ColorsController *controller = [[views objectAtIndex:0] controller];
    char colorName[1024];
    char rgbValue[1024];
    unsigned long i;

    [isa reset];
    for (i = 0; i < items; i++) {
        sprintf(colorName, "x%ld", i);
        sprintf(rgbValue, "#%ld", i);
        [controller addColorWithName:[NSString stringWithCString:colorName] 
                rgbValue:[NSString stringWithCString:rgbValue]];
        [isa proceed];
    }
    [isa reset];
}

- (void)check:(unsigned long)items
{
    NSEnumerator* enumerator = [views objectEnumerator];
    DumbColorsView* view;

    while ((view = [enumerator nextObject])) {
        if ([view drawCount] != items) {
            fprintf(stderr, "Warning: Draw count didn't match!\n");
        }
    }
}

- (void)remove:(unsigned long)items
{
    [isa reset];
    [views removeAllObjects];
    OOB_RELEASE(theModel);
    [isa reset];
}

- (void)dealloc
{
    OOB_RELEASE(views);
    [super dealloc];
}

@end

int main(int argc, char **argv, char **env) {
    SHOW_LOCATION("Patterns/MVC");
#if LIB_FOUNDATION_LIBRARY
    [NSProcessInfo initializeWithArguments:argv count:argc
            environment:env];
#endif  
    {
        OOB_CREATE_AUTORELEASE_POOL(pool);
        MVCPerformance *performance =
                [MVCPerformance newBenchmarkWithArguments:argc : argv];
        [performance testWithCount:50000l];
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
