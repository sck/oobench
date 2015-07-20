/*
 * Abstract base class for views.
 */

#import "MVC.h"

@interface View: Observer 
{
    id model;
    id controller;
}

+ viewWithModel:aModel;
- initWithModel:aModel;
- (void)update;
- model;
- controller;
- makeController;
- (void)draw;
- (void)dealloc;
@end
