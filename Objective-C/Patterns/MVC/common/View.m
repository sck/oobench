/*
 * Abstract base class for views.
 */

#import "MVC.h"

@implementation View
+ viewWithModel:aModel
{
    return OOB_AUTORELEASE([[self alloc] initWithModel:aModel]);
}

- initWithModel:aModel
{
    [self init];
    controller = OOB_RETAIN([self makeController]);
    model = OOB_RETAIN(aModel);
    [model attach:self];
    return self;
}

- (void)update
{
    [self draw];
}

- model
{
    return model;
}

- controller
{
    return controller;
}

- makeController
{
    return [Controller controllerWithView:self];
}

- (void)draw
{
    [isa subclassResponsibility:_cmd];
}

- (void)dealloc
{
    [model detach:self];
    OOB_RELEASE(model);
    OOB_RELEASE(controller);
    [super dealloc];
}

@end
