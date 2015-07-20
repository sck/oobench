#import "MVC.h"

@implementation Controller

+ controllerWithView:(View *)theView
{
    return OOB_AUTORELEASE([[self alloc] initWithView: theView]);
}

- initWithView:(View *)theView 
{
    [self init];
    view = OOB_RETAIN(theView);
    [[view model] attach:self];
    return self;
}

- (void)handleEvent:(ControllerEvent *)theEvent
{
    [isa subclassResponsibility:_cmd];
}

- (void)update 
{
    [isa subclassResponsibility:_cmd];
}

- (void)dealloc 
{
    [[view model] detach:self];
    OOB_RELEASE(view);
    [super dealloc];
}

- (View *)view 
{
    return view;
}

@end
