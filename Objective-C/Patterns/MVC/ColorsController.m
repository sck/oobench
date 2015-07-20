#import "MVC.h"
#import "ColorsModel.h"
#import "ColorsController.h"
#import "InvalidRgbFormatException.h"

@implementation ColorsController

- (void)addColorWithName:(NSString *)name rgbValue:(NSString *)rgbValue
{
    if (![rgbValue hasPrefix:@"#"]) {
        THROW([[InvalidRgbFormatException alloc] 
                initWithName:@"InvalidRgbFormatException"
                reason:@"rgbValue needs to start with '#'"
                userInfo:nil]);
    }
    [[[self view] model] addColorWithName:name rgbValue:rgbValue];
}

@end
