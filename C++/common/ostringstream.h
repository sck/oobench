#if HAVE_OSTRINGSTREAM
#   include <stringstream>
#else 
#   if !HAVE_OSTRSTREAM
#       error "Neither ostringstream nor ostrstream are present."
#   else
#       include <strstream>
#       define ostringstream ostrstream
#   endif
#endif
