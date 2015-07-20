#! /bin/sh

DIR=`dirname $0; pwd`
cd $DIR

(
    cd ..
    cvs update -dP
    gmake testAndMail
)
