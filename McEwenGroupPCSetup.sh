#/bin/bash
# McEwenGroupPCSetup.sh
# Installs plplot 5.9.9 on Ubuntu 14.04.3 Trusty Tahr
#  The intention here is to make it so that users of
#  Dr. McEwen's research group can use plplot to export
#  graphs in PDF format. There is an option to export
#  graphs in PostScript format, but these typically do
#  not look that great. PDF format is usually preferred.
#
# Written by: Tim Munson (tmunson@wsu.edu)
# Last Updated: 1/28/2016

echo ""

if [ -n "$BASH_VERSION" ]
    then
        echo "Running bash..."
    else
        echo "NOTE: You should run this script with:"
        echo "'bash plplotInstall.sh'"
        echo ""
        exit 1
fi

if [ $EUID -ne 0 ]
    then
        echo "ERROR: You need to be root when using this script."
        echo "Run the 'su' command to become root, then run this script again."
        exit 1
    else
        echo "User is root. Proceeding..."
fi

### Constants ###
ORIGINAL_WORKING_DIRECTORY=$(pwd)


print_vars() {
    echo "ORIGINAL_WORKING_DIRECTORY = $ORIGINAL_WORKING_DIRECTORY"
}

print_vars

echo "Done."
echo ""


