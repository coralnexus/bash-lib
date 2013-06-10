#!/bin/bash
#-------------------------------------------------------------------------------
#
# script_name
#
#-------------------------------------------------------------------------------
# Help

if [ -z "$HELP" ]
then
export HELP="
This script does something useful (hopefully).

--------------------------------------------------------------------------------
Tested under:   Whatever you're using to develop
Licensed under: GPLv3

See the project page at: http://domain/project
Report issues here:      http://domain/issue_tracker
"
fi

if [ -z "$USAGE" ]
then
export USAGE="
usage: script_name [ -h | --help ] | Show usage information
--------------------------------------------------------------------------------
"
fi

#-------------------------------------------------------------------------------
# Parameters

STATUS=0
SCRIPT_DIR="$(cd "$(dirname "$([ `readlink "$0"` ] && echo "`readlink "$0"`" || echo "$0")")"; pwd -P)"
SHELL_LIB_DIR="$SCRIPT_DIR/lib/shell"

source "$SHELL_LIB_DIR/load.sh" || exit 1

#---

PARAMS=`normalize_params "$@"`

parse_flag '-h|--help' HELP_WANTED

# Standard help message.
if [ "$HELP_WANTED" ]
then
    echo "$HELP"
    echo "$USAGE"
    exit 0
fi
if [ $STATUS -ne 0 ]
then
    echo "$USAGE"
    exit $STATUS    
fi

ARGS=`get_args "$PARAMS"`

#-------------------------------------------------------------------------------
# Start

exit $STATUS
