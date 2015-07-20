#import "MVC.h"
#import "ColorsController.h"
#import "DumbColorsView.h"

@implementation DumbColorsView

+ viewWithModel:(Model *)aModel andName:(const char *)aName
{
    return OOB_AUTORELEASE([[self alloc] initWithModel:aModel andName:aName]);
}

- initWithModel:(Model *)aModel andName:(const char *)aName
{
    [self initWithModel:aModel];
    if (aName != NULL) {
        name = OOB_RETAIN([NSString stringWithCString:aName]);
    } else {
        name = @"none";
    }
    return self;
}

- (Controller *)makeController
{
    return [ColorsController controllerWithView:self];
}

- (void)draw
{
    ++drawCount;
}

- (unsigned long)drawCount
{
    return drawCount;
}

- (void)dealloc
{
    OOB_RELEASE(name);
    [super dealloc];
}

@end
