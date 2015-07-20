/*
 * Common ancestor for view and controller.
 */

#import "MVC.h"

@implementation Observer
- (void)update 
{
    [isa subclassResponsibility:_cmd];
}
@end
