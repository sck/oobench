#include <Foundation/Foundation.h>

@interface Data : NSObject
+ data;
- (int)size;
@end

@implementation Data
+ data
{
    return OOB_AUTORELEASE([[self alloc] init]);
}

- (int)size
{
    return 1234;
}
@end
