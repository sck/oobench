/*
 * Abstract base class for models.
 */

#import "MVC.h"

@interface Model: NSObject
{
    NSMutableArray* observers;
}
+ model;
- (void)attach:(Observer *)anObserver;
- (void)detach:(Observer *)anObserver;
- (void)notify;
@end
