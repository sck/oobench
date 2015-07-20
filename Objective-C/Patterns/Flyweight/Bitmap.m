#import <Foundation/Foundation.h>

@interface Bitmap : NSObject
{
    Screen* screen;
    NSMutableArray* pixels;
}

+ bitmapWithScreen:(Screen *)aScreen;
- initWithScreen:(Screen *)aScreen;
- (void)show;
- (void)dealloc;
@end

@implementation Bitmap

+ bitmapWithScreen:(Screen *)aScreen
{
    return OOB_AUTORELEASE([[self alloc] initWithScreen:aScreen]); 
}

- initWithScreen:(Screen *)aScreen
{
    unsigned long i;
    unsigned long screenSize;

    [self init];
    screen = OOB_RETAIN(aScreen);
    screenSize = [screen size];
    pixels = OOB_RETAIN([NSMutableArray arrayWithCapacity:[aScreen size]]);
    for (i = 0; i < screenSize; i++) {
        [pixels addObject:[PixelPoint pixelWithValue:0]];
    }
    return self;
}

- (void)show
{
    DrawContext *context = [DrawContext contextWithScreen:screen];
    NSEnumerator *pixelEnum = [pixels objectEnumerator];
    PixelPoint* pixel;

    while ((pixel = [pixelEnum nextObject])) {
        [pixel drawWithContext:context];
        [context next];
    }
}

- (void)dealloc
{
    OOB_RELEASE(pixels);
    OOB_RELEASE(screen);
    [super dealloc];
}
@end
