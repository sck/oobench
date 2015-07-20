#import <Foundation/Foundation.h>

@interface Screen : NSObject
{
    unsigned long size;
    char *screen;
}

+ screenWithSize:(unsigned long)theSize;
- initWithSize:(unsigned long)theSize;
- (unsigned long)size;
- (char *)screenPointer;
- (void)dealloc;
@end

@implementation Screen

+ screenWithSize:(unsigned long)theSize
{
    return OOB_AUTORELEASE([[self alloc] initWithSize:theSize]);
}

- initWithSize:(unsigned long)theSize
{
    [self init];
    size = theSize;
    screen = malloc(size);
    return self;
}

- (unsigned long)size
{
    return size;
}

- (char *)screenPointer
{
    return screen;
}

- (void)dealloc
{
    free(screen);
    [super dealloc];
}

@end
