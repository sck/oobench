dnl
dnl Perl.
dnl

AC_DEFUN(AC_CHECK_PERL,[
AC_MSG_CHECKING(whether perl is present)
AC_CACHE_VAL(ac_cv_perl,[

OLDIFS=$IFS
IFS=":"

ac_cv_perl=no

for element in $PATH; do 
    if test -x $element/perl; then
        ac_cv_perl=$element/perl
        break
    fi
done

IFS=$OLDIFS

])dnl
AC_MSG_RESULT(${ac_cv_perl})
])dnl

dnl
dnl JDK-1.2.
dnl

AC_DEFUN(AC_CHECK_JAVA12_BIN,[
AC_MSG_CHECKING(whether JDK-1.2 is present)
AC_CACHE_VAL(ac_cv_jdk12_bin,[

ac_cv_jdk12_bin=no

TRIES="\
        /usr/local/linux-jdk-1.2.4 \
        /usr/local/linux-jdk-1.2.3 \
        /usr/local/linux-jdk-1.2.2 \
        /usr/local/linux-jdk-1.2.1 \
        /usr/local/linux-jdk-1.2.0 \
        /usr/local/linux-jdk1.2.5 \
        /usr/local/linux-jdk1.2.4 \
        /usr/local/linux-jdk1.2.3 \
        /usr/local/linux-jdk1.2.2 \
        /usr/local/linux-jdk1.2.1 \
        /usr/local/linux-jdk1.2.0 \
        /usr/local/linux-jdk124 \
        /usr/local/linux-jdk123 \
        /usr/local/linux-jdk122 \
        /usr/local/linux-jdk121 \
        /usr/local/linux-jdk120 \
        /usr/local/linux-jdk12 \
        /usr/local/jdk-1.2.4 \
        /usr/local/jdk-1.2.3 \
        /usr/local/jdk-1.2.2 \
        /usr/local/jdk-1.2.1 \
        /usr/local/jdk-1.2.0 \
        /usr/local/jdk1.2.5 \
        /usr/local/jdk1.2.4 \
        /usr/local/jdk1.2.3 \
        /usr/local/jdk1.2.2 \
        /usr/local/jdk1.2.1 \
        /usr/local/jdk1.2.0 \
        /usr/local/jdk124 \
        /usr/local/jdk123 \
        /usr/local/jdk122 \
        /usr/local/jdk121 \
        /usr/local/jdk120 \
        /usr/local/jdk12 \
        $JAVA_HOME \
        "
for element in $TRIES; do 
    if test -x $element/bin/javac; then
        ac_cv_jdk12_bin=$element/bin
        break;
    fi
done

if test $ac_cv_jdk12_bin = no; then
    OLDIFS=$IFS
    IFS=":"

    for element in $PATH; do 
        if test -x $element/java; then
            $element/java -version 2>&1 | grep 'jdk1.2' >/dev/null
            if test $? = 0; then
                ac_cv_jdk12_bin=$element
            fi
        fi
    done

    IFS=$OLDIFS
fi


])dnl
AC_MSG_RESULT(${ac_cv_jdk12_bin})
])dnl

dnl
dnl JDK-1.3.
dnl

AC_DEFUN(AC_CHECK_JAVA13_BIN,[
AC_MSG_CHECKING(whether JDK-1.3 is present)
AC_CACHE_VAL(ac_cv_jdk13_bin,[

ac_cv_jdk13_bin=no

TRIES="\
        /usr/local/linux-jdk-1.3.4 \
        /usr/local/linux-jdk-1.3.3 \
        /usr/local/linux-jdk-1.3.2 \
        /usr/local/linux-jdk-1.3.1 \
        /usr/local/linux-jdk-1.3.0 \
        /usr/local/linux-jdk1.3.5 \
        /usr/local/linux-jdk1.3.4 \
        /usr/local/linux-jdk1.3.3 \
        /usr/local/linux-jdk1.3.2 \
        /usr/local/linux-jdk1.3.1 \
        /usr/local/linux-jdk1.3.0 \
        /usr/local/linux-jdk134 \
        /usr/local/linux-jdk133 \
        /usr/local/linux-jdk132 \
        /usr/local/linux-jdk131 \
        /usr/local/linux-jdk130 \
        /usr/local/linux-jdk13 \
        /usr/local/jdk-1.3.4 \
        /usr/local/jdk-1.3.3 \
        /usr/local/jdk-1.3.2 \
        /usr/local/jdk-1.3.1 \
        /usr/local/jdk-1.3.0 \
        /usr/local/jdk1.3.5 \
        /usr/local/jdk1.3.4 \
        /usr/local/jdk1.3.3 \
        /usr/local/jdk1.3.2 \
        /usr/local/jdk1.3.1 \
        /usr/local/jdk1.3.0 \
        /usr/local/jdk134 \
        /usr/local/jdk133 \
        /usr/local/jdk132 \
        /usr/local/jdk131 \
        /usr/local/jdk130 \
        /usr/local/jdk13 \
        $JAVA_HOME \
        "
for element in $TRIES; do 
    if test -x $element/bin/javac; then
        ac_cv_jdk13_bin=$element/bin
        break;
    fi
done

if test $ac_cv_jdk13_bin = no; then
    OLDIFS=$IFS
    IFS=":"

    for element in $PATH; do 
        if test -x $element/java; then
            $element/java -version 2>&1 | grep 'jdk1.3' >/dev/null
            if test $? = 0; then
                ac_cv_jdk13_bin=$element
            fi
        fi
    done

    IFS=$OLDIFS
fi

])dnl
AC_MSG_RESULT(${ac_cv_jdk13_bin})

if test $ac_cv_jdk13_bin != no; then
    ac_cv_tools_jar=`cd $ac_cv_jdk13_bin/../lib; pwd`/tools.jar
fi

])dnl

dnl
dnl Ant.
dnl

AC_DEFUN(AC_CHECK_ANT,[
AC_MSG_CHECKING(whether ant is present)
AC_CACHE_VAL(ac_cv_ant,[

OLDIFS=$IFS
IFS=":"

ac_cv_ant=no

TRIES="$ANT_HOME:$PATH"

for element in $TRIES; do 
    if test -x $element/ant; then
        ac_cv_ant=$element/ant
        break;
    fi
done

IFS=$OLDIFS

])dnl
AC_MSG_RESULT(${ac_cv_ant})

ac_cv_ant_classes=

TRIES="\
        $ANT_HOME/lib \
        $ac_cv_ant/../lib \
        /usr/local/ant/lib \
        /usr/local/lib \
        $HOME/local/ant/lib \
        $HOME/local/lib \
        "

for element in $TRIES; do 
    result=`ls $element/*ant*.jar 2>/dev/null`
    if test "x$result" != "x"; then
        ac_cv_ant_classes=$result
        break;
    fi
done

])dnl

dnl
dnl J2SDKEE.
dnl

AC_DEFUN(AC_CHECK_J2SDKEE_ROOT,[
AC_MSG_CHECKING(whether J2SDKEE is present)
AC_CACHE_VAL(ac_cv_j2sdkee_root,[

ac_cv_j2sdkee_root=no

TRIES="\
        $J2EE_HOME \
        $J2SDKEE \
        $J2SDKEE_ROOT \
        /usr/j2sdkee \
        /usr/local/j2sdkee \
        "
for element in $TRIES; do 
    if test -x $element/bin/deploytool; then
        ac_cv_j2sdkee_root=$element
        break;
    fi
done


])dnl
AC_MSG_RESULT(${ac_cv_j2sdkee_root})

ac_cv_j2sdkee_classes=

TRIES="\
        $ac_cv_j2sdkee_root/lib \
        "

for element in $TRIES; do 
    result=`ls $element/j2ee.jar 2>/dev/null`
    if test "x$result" != "x"; then
        ac_cv_j2sdkee_classes=`echo $element/*.jar | sed -e 's| |:|g'`
        break;
    fi
done
])dnl

dnl
dnl JBoss.
dnl

AC_DEFUN(AC_CHECK_JBOSS_ROOT,[
AC_MSG_CHECKING(whether JBoss is present)
AC_CACHE_VAL(ac_cv_jboss_root,[

ac_cv_jboss_root=no

TRIES="\
        $JBOSS \
        $JBOSS_DIR \
        /usr/local/jboss \
        /usr/local/jboss/dist \
        "
for element in $TRIES; do 
    if test -x $element/deploy; then
        ac_cv_jboss_root=$element
        break;
    fi
done


])dnl
AC_MSG_RESULT(${ac_cv_jboss_root})

ac_cv_jboss_classes=

TRIES="\
        $ac_cv_jboss_root/client \
        $JBOSS/client \
        $JBOSS_DIR/client \
        /usr/local/jboss/client \
        /usr/local/jboss/dist/client \
        "

for element in $TRIES; do 
    result=`ls $element/*.jar 2>/dev/null`
    if test "x$result" != "x"; then
        ac_cv_jboss_classes=`echo $element/*.jar | sed -e 's| |:|g'`
        break;
    fi
done
])dnl

dnl
dnl BEA Weblogic.
dnl

AC_DEFUN(AC_CHECK_WEBLOGIC_ROOT,[
AC_MSG_CHECKING(whether BEA Weblogic is present)
AC_CACHE_VAL(ac_cv_weblogic_root,[

ac_cv_weblogic_root=no

TRIES="\
        $WL_HOME \
        $WLS \
        /usr/weblogic \
        /usr/local/weblogic \
        "
for element in $TRIES; do 
    if test -x $element/lib; then
        ac_cv_weblogic_root=$element
        break;
    fi
done


])dnl
AC_MSG_RESULT(${ac_cv_weblogic_root})

ac_cv_weblogic_classes=

TRIES="\
        $ac_cv_weblogic_root/lib \
        "

for element in $TRIES; do 
    result=`ls $element/*.jar 2>/dev/null`
    if test "x$result" != "x"; then
        ac_cv_weblogic_classes=`echo $element/*.jar | sed -e 's| |:|g'`
        break;
    fi
done

ac_cv_weblogic_classes=$ac_cv_weblogic_classes:$ac_cv_weblogic_root/classes
])dnl

dnl
dnl ATG Dynamo.
dnl

AC_DEFUN(AC_CHECK_DYNAMO_ROOT,[
AC_MSG_CHECKING(whether ATG Dynamo is present)
AC_CACHE_VAL(ac_cv_dynamo_root,[

ac_cv_dynamo_root=no

TRIES="\
        $ATG_HOME \
        $ATG \
        $DYNAMO_HOME \
        $DYNAMO \
        /usr/dynamo \
        /usr/local/dynamo \
        "
for element in $TRIES; do 
    if test -x $element/DAS/lib; then
        ac_cv_dynamo_root=$element
        break;
    fi
done


])dnl
AC_MSG_RESULT(${ac_cv_dynamo_root})

ac_cv_dynamo_classes=

TRIES="\
        $ac_cv_dynamo_root/DAS/lib \
        "

for element in $TRIES; do 
    result=`ls $element/*.jar 2>/dev/null`
    if test "x$result" != "x"; then
        ac_cv_dynamo_classes=`echo $element/*.jar | sed -e 's| |:|g'`
        break;
    fi
done
])dnl

dnl
dnl Orion Server.
dnl

AC_DEFUN(AC_CHECK_ORION_ROOT,[
AC_MSG_CHECKING(whether Orion Server is present)
AC_CACHE_VAL(ac_cv_orion_root,[

ac_cv_orion_root=no

TRIES="\
        $ORION_HOME \
        $ORION \
        $ORION_SERVER_HOME \
        $ORION_SERVER \
        $ORIONSERVER \
        $ORIONSERVERHOME \
        /usr/orion \
        /usr/local/orion \
        "
for element in $TRIES; do 
    if test -x $element/ejb.jar; then
        ac_cv_orion_root=$element
        break;
    fi
done


])dnl
AC_MSG_RESULT(${ac_cv_orion_root})

ac_cv_orion_classes=

TRIES="\
        $ac_cv_orion_root \
        "

for element in $TRIES; do 
    result=`ls $element/ejb.jar $element/orion.jar 2>/dev/null`
    if test "x$result" != "x"; then
        ac_cv_orion_classes=`echo $result | sed -e 's| |:|g'`
        break;
    fi
done
])dnl
