dnl
dnl Macro copied from libFoundation.
dnl

AC_DEFUN(AC_LANG_OBJECTIVE_C,
[AC_REQUIRE([AC_PROG_CC])dnl
define([AC_LANG], [AC_LANG_OBJECTIVE_C])dnl
ac_ext=m
# CFLAGS is not in ac_cpp because -g, -O, etc. are not valid cpp options.
ac_cpp='$CPP $OBJC_RUNTIME_FLAG'
ac_compile='${CC-cc} -c $OBJC_RUNTIME_FLAG $CFLAGS $CFLAGS_LF conftest.$ac_ext 1>&AC_FD_CC 2>&AC_FD_CC'
ac_link='${CC-cc} -o conftest $OBJC_RUNTIME_FLAG $CFLAGS $CFLAGS_LF $LDFLAGS $LDFLAGS_LF conftest.$ac_ext $LIBS_LF $LIBS $OBJC_LIBS 1>&AC_FD_CC 2>&AC_FD_CC'
])dnl

dnl
dnl Macro copied from libFoundation.
dnl

AC_DEFUN(AC_FIND_RUNTIME,
[AC_REQUIRE([AC_PROG_CC])dnl
AC_MSG_CHECKING(for the Objective-C runtime)
AC_CACHE_VAL(ac_cv_objc_runtime,
[if test "$OBJC_RUNTIME" = ""; then
AC_LANG_SAVE[]dnl
AC_LANG_OBJECTIVE_C[]
AC_TRY_LINK([#include <objc/Object.h>],
[extern id objc_lookUpClass(char*);
id class = objc_lookUpClass("Object");
id obj = [class alloc];
puts([obj name]);
], [
    ac_cv_objc_runtime=NeXT
    ac_cv_objc_libs=""
], ac_cv_objc_runtime=unknown)
if test $ac_cv_objc_runtime = unknown; then
    # Save the LIBS variable
    OLD_LIBS=$LIBS
    LIBS="-lobjc $LIBS"
    AC_TRY_LINK([#include <objc/Object.h>],
    [extern id objc_lookup_class(char*);
    id class = objc_lookup_class("Object");
    id obj = [class alloc];
    puts([obj name]);
    ], [
        ac_cv_objc_runtime=GNU
        ac_cv_objc_libs="-lobjc"
    ], ac_cv_objc_runtime=unknown)

    if test $ac_cv_objc_runtime = unknown; then
        LIBS="$LIBS -lpthread"
        AC_TRY_LINK([#include <objc/Object.h>],
        [extern id objc_lookup_class(char*);
        id class = objc_lookup_class("Object");
        id obj = [class alloc];
        puts([obj name]);
        ], [
            ac_cv_objc_runtime=GNU
            ac_cv_objc_libs="-lobjc -lpthread"
        ], ac_cv_objc_runtime=unknown)

        if test $ac_cv_objc_runtime = unknown; then
            LIBS="$LIBS -ldl"
            AC_TRY_LINK([#include <objc/Object.h>],
            [extern id objc_lookup_class(char*);
            id class = objc_lookup_class("Object");
            id obj = [class alloc];
            puts([obj name]);
            ], [
                ac_cv_objc_runtime=GNU
                ac_cv_objc_libs="-lobjc -lpthread -ldl"
            ], ac_cv_objc_runtime=unknown)
            # MAC OS X.  Thanks to John Blitch <phiporiphic@gmail.com> 
            # for pointing out.
            if test $ac_cv_objc_runtime = unknown; then
                LIBS="-framework foundation"
                AC_TRY_LINK([#include <objc/Object.h>],
                [extern id objc_lookup_class(char*);
                id class = [Object class];
                id obj = [class alloc];
                puts([obj name]);
                ], [
                    ac_cv_objc_runtime=GNU-MACOSX
                    ac_cv_objc_libs="-framework foundation"
                ], ac_cv_objc_runtime=unknown)
            fi
        fi
    fi

    # Restore the LIBS variable
    LIBS=$OLD_LIBS
    fi
    AC_LANG_RESTORE[]
else
    ac_cv_objc_runtime=$OBJC_RUNTIME
fi
])dnl
if test "`echo ${ac_cv_objc_runtime} | tr a-z A-Z`" = "GNU"; then
    OBJC_RUNTIME=GNU
    OBJC_RUNTIME_FLAG=-fgnu-runtime
    ac_cv_objc_runtime=GNU
    LIBS="$LIBS $ac_cv_objc_libs"
    AC_DEFINE(GNU_RUNTIME)
elif test "`echo ${ac_cv_objc_runtime} | tr a-z A-Z`" = "NEXT"; then
    OBJC_RUNTIME=NeXT
    OBJC_RUNTIME_FLAG=-fnext-runtime
    ac_cv_objc_runtime=NeXT
    AC_DEFINE(NeXT_RUNTIME)
elif test "`echo ${ac_cv_objc_runtime} | tr a-z A-Z`" = "GNU-MACOSX"; then
    OBJC_RUNTIME=GNU-MACOSX
    OBJC_RUNTIME_FLAG=
    ac_cv_objc_runtime=GNU-MACOSX
    AC_DEFINE(GNU_RUNTIME)
    AC_DEFINE(MACOSX_FOUNDATION)
    ac_cv_macosx_foundation_present=yes
    ac_cv_foundation_present=yes
else
    echo
    rm -f conftest* confdefs* core core.* *.core
    echo "Cannot determine the Objective-C runtime!
--> Probably you have to specify some additional libraries needed to link an 
    ObjC program, so please take a look in the config.log file to see the 
    reason.  Stop."
    exit 1
fi
AC_MSG_RESULT(${ac_cv_objc_runtime})
])dnl

dnl
dnl Foundation library.
dnl

AC_DEFUN(AC_FIND_FOUNDATION_LIB,
[AC_REQUIRE([AC_PROG_CC])dnl
AC_MSG_CHECKING(whether the Foundation library is present)
AC_CACHE_VAL(ac_cv_foundation_present,
AC_LANG_SAVE[]dnl
AC_LANG_OBJECTIVE_C[]
[

if test "x$ac_foundation_root" = "x"; then
    ac_foundation_root=/usr/local/libFoundation
fi

if test -d $ac_foundation_root; then
    FOUNDATION_ROOT=$ac_foundation_root
    LIB_FOUNDATION_LIB=${FOUNDATION_ROOT}/lib
    LIB_FOUNDATION_INCLUDE=${FOUNDATION_ROOT}/include
    CFLAGS_LF="-I${LIB_FOUNDATION_INCLUDE}"
    LDFLAGS_LF="-L${LIB_FOUNDATION_LIB}"
    LIBS_LF="-lFoundation"
fi

AC_TRY_LINK([#include <Foundation/Foundation.h>],
[char *dummy[2] = {(char *)NULL, (char *)NULL};
#if LIB_FOUNDATION_LIBRARY
[NSProcessInfo initializeWithArguments:dummy count:0 environment:dummy];
#endif
{
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    [pool release];
}
], [ac_cv_foundation_present=yes;
ac_cv_foundation_include_path=$LIB_FOUNDATION_INCLUDE
ac_cv_foundation_lib_path=$LIB_FOUNDATION_LIB
ac_cv_foundation_libs=$LIBS_LF
], ac_cv_foundation_present=no)

if test $ac_cv_foundation_present = no; then
    LIBS_LF="$LIBS_LF -lm"
    AC_TRY_LINK([#include <Foundation/Foundation.h>],
    [char *dummy[2] = {(char *)NULL, (char *)NULL};
    #if LIB_FOUNDATION_LIBRARY
    [NSProcessInfo initializeWithArguments:dummy count:0 
            environment:dummy];
    #endif
    {
        NSAutoreleasePool *pool = [NSAutoreleasePool new];
        [pool release];
    }
    ], [ac_cv_foundation_present=yes;
    ac_cv_foundation_include_path=$LIB_FOUNDATION_INCLUDE
    ac_cv_foundation_lib_path=$LIB_FOUNDATION_LIB
    ac_cv_foundation_libs=$LIBS_LF
    ], ac_cv_foundation_present=no)
    if test $ac_cv_foundation_present = no; then
        LIBS_LF="$LIBS_LF -lpthread"
        AC_TRY_LINK([#include <Foundation/Foundation.h>],
        [char *dummy[2] = {(char *)NULL, (char *)NULL};
        #if LIB_FOUNDATION_LIBRARY
        [NSProcessInfo initializeWithArguments:dummy count:0 
                environment:dummy];
        #endif
        {
            NSAutoreleasePool *pool = [NSAutoreleasePool new];
            [pool release];
        }
        ], [ac_cv_foundation_present=yes;
        ac_cv_foundation_include_path=$LIB_FOUNDATION_INCLUDE
        ac_cv_foundation_lib_path=$LIB_FOUNDATION_LIB
        ac_cv_foundation_libs=$LIBS_LF
        ], ac_cv_foundation_present=no)
        if test $ac_cv_foundation_present = no; then
            LIBS_LF="$LIBS_LF -ldl"
            AC_TRY_LINK([#include <Foundation/Foundation.h>],
            [char *dummy[2] = {(char *)NULL, (char *)NULL};
            #if LIB_FOUNDATION_LIBRARY
            [NSProcessInfo initializeWithArguments:dummy count:0
                    environment:dummy];
            #endif
            {
                NSAutoreleasePool *pool = [NSAutoreleasePool new];
                [pool release];
            }
            ], [ac_cv_foundation_present=yes;
            ac_cv_foundation_include_path=$LIB_FOUNDATION_INCLUDE
            ac_cv_foundation_lib_path=$LIB_FOUNDATION_LIB
            ac_cv_foundation_libs=$LIBS_LF
            ], ac_cv_foundation_present=no)
            if test $ac_cv_foundation_present = no; then
                LIBS_LF="$LIBS_LF -lposix4"
                AC_TRY_LINK([#include <Foundation/Foundation.h>],
                [char *dummy[2] = {(char *)NULL, (char *)NULL};
                #if LIB_FOUNDATION_LIBRARY
                [NSProcessInfo initializeWithArguments:dummy count:0 
                        environment:dummy];
                #endif
                {
                    NSAutoreleasePool *pool = [NSAutoreleasePool new];
                    [pool release];
                }
                ], [ac_cv_foundation_present=yes;
                ac_cv_foundation_include_path=$LIB_FOUNDATION_INCLUDE
                ac_cv_foundation_lib_path=$LIB_FOUNDATION_LIB
                ac_cv_foundation_libs=$LIBS_LF
                ], ac_cv_foundation_present=no)
            fi
        fi
    fi
fi
AC_LANG_RESTORE[]
])dnl

if test $ac_cv_foundation_present = no; then
    echo
    rm -f conftest* confdefs* core core.* *.core
    echo "Cannot determine the Foundation library! 
--> Probably you have to specify some additional libraries needed to link an 
    Foundation program, so please take a look in the config.log file to see 
    the reason and try again."
else
    ac_cv_lib_foundation_resources_path=
    if test -d $ac_foundation_root/share/libFoundation/CharacterSets; then
        ac_cv_lib_foundation_resources_path=$ac_foundation_root/share/libFoundation
    fi
fi

AC_MSG_RESULT(${ac_cv_foundation_present})
])dnl
