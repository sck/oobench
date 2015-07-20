#include <Foundation/Foundation.h>

@interface PixelPoint : NSObject
{
    char pixel;
}
+ pixelWithValue:(char)value;
- initWithValue:(char)value;
- (void)drawWithContext:(DrawContext *)dc;
- (char)pixel;
@end

@implementation PixelPoint

+ pixelWithValue:(char)value
{
    return OOB_AUTORELEASE([[self alloc] initWithValue:value]);
}

- initWithValue:(char)value
{
    [self init];
    pixel = value;
    return self;
}

- (void)drawWithContext:(DrawContext *)dc
{
    *[dc pointer] = pixel;
}

- (char)pixel
{
    return pixel;
}
@end
