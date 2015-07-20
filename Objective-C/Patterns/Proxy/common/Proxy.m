#import <Foundation/Foundation.h>

extern retval_t objc_msg_sendv(id, SEL, arglist_t);

@interface Proxy : NSObject
{
    id _obj;
}
+ proxyWithObject:anObject;
- initWithObject:anObject;
@end

@implementation Proxy

+ proxyWithObject:anObject
{
    return OOB_AUTORELEASE([[self alloc] initWithObject:anObject]);
}

- initWithObject:anObject
{
    [self init];
    _obj = OOB_RETAIN(anObject);
    return self;
}

- (retval_t)forward:(SEL)selector:(arglist_t)argframe
{
    return objc_msg_sendv(_obj, selector, argframe);
}

- (void)dealloc 
{
    OOB_RELEASE(_obj);
    [super dealloc];
}
@end
