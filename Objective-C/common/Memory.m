#include <Foundation/Foundation.h>

#include <unistd.h>

@interface Memory : NSObject
+ (long)usedMemory;
@end

@implementation Memory
+ (long)usedMemory 
{
    return (long)sbrk(0);
}
@end
