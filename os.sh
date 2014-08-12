#!/bin/bash
#
# os.sh
#
# Most of this file is currently derived from:
#
# https://github.com/coto/server-easy-install/blob/master/lib/core.sh
#
#-------------------------------------------------------------------------------

function os_info() {
    OS=`lowercase \`uname\``
    KERNEL=`uname -r`
    MACHINE=`uname -m`

    #---

    if [ "${OS}" == "windowsnt" ]
    then
        OS=windows
    
    elif [ "${OS}" == "darwin" ]
    then
        OS=mac
    else
        if [ "${OS}" = "linux" ]
        then
            if [ -f /etc/redhat-release ]
            then
                OS=`cat /etc/redhat-release |sed s/\ release.*//`
                OS_NAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
                OS_VERSION=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
            
            elif [ -f /etc/SuSE-release ]
            then
            	OS=suse
                OS_NAME=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
                OS_VERSION=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
        
            elif [ -f /etc/mandrake-release ]
            then
                OS=mandriva
                OS_NAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
                OS_VERSION=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
        
            elif [ -f /etc/debian_version ]
            then
                DIST=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }'`
                OS_NAME=`cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F=  '{ print $2 }'`
                OS_VERSION=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{ print $2 }'`
            fi
            if [ -f /etc/UnitedLinux-release ]
            then
                DIST="${DIST}[`cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//`]"
            fi
            OS=`lowercase "$DIST"`
        fi
    fi
}

#-------------------------------------------------------------------------------
# Utilities

function lowercase() {
    echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

