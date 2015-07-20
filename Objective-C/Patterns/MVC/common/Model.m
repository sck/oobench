/*
 * Abstract base class for models.
 */

#import "MVC.h"

@implementation Model

+ model
{
    return OOB_AUTORELEASE([[self alloc] init]);
}

- init 
{
    [super init];
    observers = OOB_RETAIN([NSMutableArray array]);
    return self;
}

- (void)attach:(Observer *)anObserver
{
    [observers addObject:anObserver];
}

- (void)detach:(Observer *)anObserver
{
    unsigned int index = [observers indexOfObjectIdenticalTo:anObserver];
    if (index != NSNotFound) {
        [observers removeObjectAtIndex:index];
    }
}

- (void)notify
{
    [observers makeObjectsPerformSelector:@selector(update)];
}

- (void)dealloc
{
    OOB_RELEASE(observers);
    [super dealloc];
}

@end
