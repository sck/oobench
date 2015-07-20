#import <Foundation/Foundation.h>

@interface DrawContext : NSObject 
{
    Screen *screen;
    char *pointer;
}

+ contextWithScreen:(Screen *)aScreen;
- initWithScreen:(Screen *)aScreen;
- (void)next;
- (void)nextSkip:(int)step;
- (char *)pointer;
@end;

@implementation DrawContext

+ contextWithScreen:(Screen *)aScreen
{
    return OOB_AUTORELEASE([[self alloc] initWithScreen:aScreen]);
}

- initWithScreen:(Screen *)aScreen
{
    [self init];
    screen = aScreen;
    pointer = [screen screenPointer];
    return self;
}

- (void)nextSkip:(int)step
{
    pointer += step;
}

- (void)next
{
    pointer++;
}

- (char *)pointer
{
    return pointer;
}

@end
