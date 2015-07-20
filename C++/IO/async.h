#include "../common/config.h"

#include <sys/stat.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>

#if !HAVE_O_ASYNC && HAVE_FASYNC
#   include <sys/file.h>
#   define IO_ASYNC FASYNC
#else
#   if !HAVE_O_ASYNC
#       error "Neither O_ASYNC nor FASYNC present."
#   endif
#   define IO_ASYNC O_ASYNC
#endif
