dnl
dnl
dnl

AC_DEFUN(AC_CHECK_PTHREADS_WORK,
[AC_REQUIRE([AC_PROG_CC])dnl
AC_MSG_CHECKING(how to compile a program using POSIX threads)
AC_CACHE_VAL(ac_cv_pthreads_work,
[AC_LANG_SAVE[]dnl
AC_LANG_C[]
OLDCFLAGS=$CFLAGS

AC_TRY_LINK([#include <pthread.h>],
[void *(*dummy)(void *);
pthread_t threadId;
dummy = 0x0;
pthread_create(&threadId, NULL, dummy, NULL);
pthread_join(threadId, NULL);
],[
ac_cv_pthreads_work=yes
ac_cv_pthreads_cc_flags=
ac_cv_pthreads_cc_libs=
], ac_cv_pthreads_work=no)

if test $ac_cv_pthreads_work = no; then
    CFLAGS="-pthread $CFLAGS"
    AC_TRY_LINK([#include <pthread.h>],
    [void *(*dummy)(void *);
    pthread_t threadId;
    dummy = 0x0;
    pthread_create(&threadId, NULL, dummy, NULL);
    pthread_join(threadId, NULL);
    ], [
        ac_cv_pthreads_work=yes
        ac_cv_pthreads_cc_flags=-pthread
        ac_cv_pthreads_cc_libs=
    ], ac_cv_pthreads_work=no)
    if test $ac_cv_pthreads_work = no; then
        CFLAGS=$OLDCFLAGS
        LIBS="-lpthread $LIBS"
        AC_TRY_LINK([#include <pthread.h>],
        [void *(*dummy)(void *);
        pthread_t threadId;
        dummy = 0x0;
        pthread_create(&threadId, NULL, dummy, NULL);
        pthread_join(threadId, NULL);
        ], [
            ac_cv_pthreads_work=yes
            ac_cv_pthreads_cc_flags=
            ac_cv_pthreads_cc_libs=-lpthread
        ], ac_cv_pthreads_work=no)
    fi
fi
AC_LANG_RESTORE[]
CFLAGS=$OLDCFLAGS
])dnl
if test $ac_cv_pthreads_work = no; then
    AC_MSG_RESULT(failed!)
else 
    AC_MSG_RESULT(flags: $ac_cv_pthreads_cc_flags; libs: $ac_cv_pthreads_cc_libs)
fi
])dnl

dnl
dnl
dnl

AC_DEFUN(AC_CHECK_LINUX_THREADS,
[AC_REQUIRE([AC_PROG_CC])dnl
AC_MSG_CHECKING(whether FreeBSD's linux threads are present)
AC_CACHE_VAL(ac_cv_linux_threads,
[AC_LANG_SAVE[]dnl
AC_LANG_C[]

CFLAGS_TRY="-D_THREAD_SAFE -I/usr/local/include/pthread/linuxthreads"
LDFLAGS_TRY="-L/usr/local/lib"
LIBS_TRY="-llthread -llgcc_r"

OLDCFLAGS=$CFLAGS
OLDLDFLAGS=$LDFLAGS
OLDLIBS=$LIBS
CFLAGS="$CFLAGS_TRY $CFLAGS"
LDFLAGS="$LDFLAGS_TRY $LDFLAGS"
LIBS="$LIBS_TRY $LIBS"

AC_TRY_LINK([#include <pthread.h>],
[void *(*dummy)(void *);
pthread_t threadId;
dummy = 0x0;
pthread_create(&threadId, NULL, dummy, NULL);
pthread_join(threadId, NULL);
], [ac_cv_linux_threads=yes
ac_cv_linux_threads_cflags=$CFLAGS_TRY
ac_cv_linux_threads_ldflags=$LDFLAGS_TRY
ac_cv_linux_threads_libs=$LIBS_TRY], 
ac_cv_linux_threads=no)

CFLAGS=$OLDCFLAGS
LDFLAGS=$OLDLDFLAGS
LIBS=$OLDLIBS
AC_LANG_RESTORE[]
])dnl
AC_MSG_RESULT(${ac_cv_linux_threads})
])dnl

dnl
dnl Check for O_ASYNC.
dnl
AC_DEFUN(AC_CHECK_FCNTL_O_ASYNC,
[AC_REQUIRE([AC_PROG_CC])dnl
AC_MSG_CHECKING(whether fcntl supports O_ASYNC)
AC_CACHE_VAL(ac_cv_fcntl_o_async,
[AC_LANG_SAVE[]dnl
AC_LANG_C[]

AC_TRY_LINK([#include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
],
[
int dummy = 0;
fcntl(dummy, F_SETFL, O_ASYNC);
], ac_cv_fcntl_o_async=yes, 
ac_cv_fcntl_o_async=no)

AC_LANG_RESTORE[]
])dnl
AC_MSG_RESULT(${ac_cv_fcntl_o_async})
])dnl

dnl
dnl Check for FASYNC.
dnl
AC_DEFUN(AC_CHECK_FCNTL_FASYNC,
[AC_REQUIRE([AC_PROG_CC])dnl
AC_MSG_CHECKING(whether fcntl supports FASYNC)
AC_CACHE_VAL(ac_cv_fcntl_fasync,
[AC_LANG_SAVE[]dnl
AC_LANG_C[]

AC_TRY_LINK([#include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <sys/file.h>
],
[
int dummy = 0;
fcntl(dummy, F_SETFL, FASYNC);
], ac_cv_fcntl_fasync=yes, 
ac_cv_fcntl_fasync=no)

AC_LANG_RESTORE[]
])dnl
AC_MSG_RESULT(${ac_cv_fcntl_fasync})
])dnl

dnl
dnl Check for ostringstream.
dnl
AC_DEFUN(AC_CHECK_OSTRINGSTREAM,
[AC_REQUIRE([AC_PROG_CC])dnl
AC_MSG_CHECKING(whether you have ostringstream)
AC_CACHE_VAL(ac_cv_ostringstream,
[
    AC_LANG_SAVE[]
    AC_LANG_CPLUSPLUS[]
    AC_TRY_LINK([#include <stringstream>],
    [
        std::ostrstream dummy;
        int i = 1;
        dummy << "dummy ";
        dummy << "yummy, ";
        dummy << "i = " << i;
    ], ac_cv_ostringstream=yes, 
    ac_cv_ostringstream=no)
    AC_LANG_RESTORE[]
])dnl
AC_MSG_RESULT(${ac_cv_ostringstream})
])dnl

dnl
dnl Check for ostrstream.
dnl
AC_DEFUN(AC_CHECK_OSTRSTREAM,
[AC_REQUIRE([AC_PROG_CC])dnl
AC_MSG_CHECKING(whether you have ostrstream)
AC_CACHE_VAL(ac_cv_ostrstream,
[
    AC_LANG_SAVE[]
    AC_LANG_CPLUSPLUS[]
    AC_TRY_LINK([#include <strstream>],
    [
        std::ostrstream dummy;
        int i = 1;
        dummy << "dummy ";
        dummy << "yummy, ";
        dummy << "i = " << i;
    ], ac_cv_ostrstream=yes, 
    ac_cv_ostrstream=no)

    ])dnl
    AC_MSG_RESULT(${ac_cv_ostrstream})
    AC_LANG_RESTORE[]
])dnl
