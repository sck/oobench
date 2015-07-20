#include "config.h"

#ifdef OOB_USE_AUTORELEASE_POOLS
#   ifndef OOB_RELEASE
#       define OOB_RELEASE(obj) \
                [obj release]
#   endif
#   ifndef OOB_RETAIN
#       define OOB_RETAIN(obj) \
                [obj retain]
#   endif
#   ifndef OOB_AUTORELEASE
#       define OOB_AUTORELEASE(obj) \
                [obj autorelease]
#   endif
#   ifndef OOB_CREATE_AUTORELEASE_POOL
#   define OOB_CREATE_AUTORELEASE_POOL(pool) \
            id pool = [[NSAutoreleasePool alloc] init]
#   endif
#else
#   ifndef OOB_RELEASE
#       define OOB_RELEASE(obj) 
#   endif
#   ifndef OOB_RETAIN
#       define OOB_RETAIN(obj) 
#   endif
#   ifndef OOB_AUTORELEASE
#       define OOB_AUTORELEASE(obj) 
#   endif
#   ifndef OOB_CREATE_AUTORELEASE_POOL
#   define OOB_CREATE_AUTORELEASE_POOL(pool) 
#   endif
#endif
