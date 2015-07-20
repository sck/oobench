#include <Foundation/Foundation.h>
int main() {
char *dummy[2] = {(char *)NULL, (char *)NULL};
    #if LIB_FOUNDATION_LIBRARY
    [NSProcessInfo initializeWithArguments:dummy count:0 
            environment:dummy];
    #endif
    {
        NSAutoreleasePool *pool = [NSAutoreleasePool new];
        [pool release];
    }
    
; return 0; }

