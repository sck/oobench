#import "MVC.h"
#import "ColorsModel.h"

@implementation ColorsModel

- init
{
    [super init];
    colors = OOB_RETAIN([NSMutableDictionary dictionary]);
    return self;
}

- (NSString *)rgbForColor:(NSString *)color
{
    return [colors objectForKey:color];
}

- (NSDictionary *)colors
{
    return colors;
}

- (void)addColorWithName:(NSString *)name rgbValue:(NSString *)rgbValue
{
    [colors setObject:rgbValue forKey:name];
    [self notify];
}

- (void)dealloc
{
    OOB_RELEASE(colors);
    [super dealloc];
}

@end
