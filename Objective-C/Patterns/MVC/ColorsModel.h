#import "MVC.h"

@interface ColorsModel : Model
{
    NSMutableDictionary *colors;
}
- init;
- (NSString *)rgbForColor:(NSString *)color;
- (NSDictionary *)colors;
- (void)addColorWithName:(NSString *)name rgbValue:(NSString *)rgbValue;
@end
