/*
 * Common base class for controllers.
 */

#import "Observer.h"

@interface Controller : Observer 
{
    id view;
}

+ controllerWithView:theView;
- initWithView:theView;
- (void)handleEvent:theEvent;
- (void)update;
- (void)dealloc;
- view;

@end
