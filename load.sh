#!/bin/bash
#
# load.sh
#
#-------------------------------------------------------------------------------
# Shared functions

#-------------------------------------------------------------------------------
# Get the directory of the command passed via the first parameter.
#
# USAGE:> SCRIPT_DIR=`get_command_location $0`
#
function get_command_location()
{
    local SCRIPT_DIR="$(cd "$(dirname "$([ `readlink "$1"` ] && echo "`readlink "$1"`" || echo "$1")")"; pwd -P)"
    
    # Return the final directory found. 
    echo "$SCRIPT_DIR"
    return 0
}

#-------------------------------------------------------------------------------
# Initialization

if [ ! -d "$SHELL_LIB_DIR" ]
then
	SHELL_LIB_DIR=`get_command_location $0`
fi

#-------------------------------------------------------------------------------

# Load command utilities.  This should always be loaded first.
COMMON_COMMAND="$SHELL_LIB_DIR/command.sh"

if [ -f "$COMMON_COMMAND" ]
then
	source "$COMMON_COMMAND"
fi

# Load os utilities.
COMMON_OS="$SHELL_LIB_DIR/os.sh"

if [ -f "$COMMON_OS" ]
then
    source "$COMMON_OS"
    os_info
fi

# Load file system utilities.
COMMON_FILESYSTEM="$SHELL_LIB_DIR/filesystem.sh"

if [ -f "$COMMON_FILESYSTEM" ]
then
	source "$COMMON_FILESYSTEM"
fi

# Load script utilities.
COMMON_SCRIPT="$SHELL_LIB_DIR/script.sh"

if [ -f "$COMMON_SCRIPT" ]
then
	source "$COMMON_SCRIPT"
fi

#-------------------------------------------------------------------------------

# Load any validators used in parse_option() calls.
COMMON_VALIDATORS="$SHELL_LIB_DIR/validators.sh"

if [ -f "$COMMON_VALIDATORS" ]
then
	source "$COMMON_VALIDATORS"
fi
