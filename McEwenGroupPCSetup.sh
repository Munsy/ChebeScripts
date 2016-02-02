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

echo -n "Enter the name of the user you want to set up and press [ENTER]: "
read NEWUSER

### Constants ###
ORIGINAL_WORKING_DIRECTORY=$(pwd)
PLPLOT_URL="http://downloads.sourceforge.net/project/plplot/plplot/5.9.9%20Source/plplot-5.9.9.tar.gz"
PLPLOTVERSION="5.9.9"

# Functions
print_vars() {
    echo "ORIGINAL_WORKING_DIRECTORY = $ORIGINAL_WORKING_DIRECTORY"
    echo "PLPLOT_URL = $PLPLOT_URLURL"
    echo "PLPLOTVERSION = $PLPLOTVERSION"
    echo "NEWUSER = $NEWUSER"
}

# Begin install
print_vars

## Base/Main
apt-get install libltdl3-dev          # A system independent dlopen wrapper for GNU libtool.
apt-get install libqhull-dev          # Calculates convex hulls and related structures.

## Manual
apt-get install texlive-latex-base    # TeX Live: Basic LaTeX packages.
apt-get install texinfo               # Documentation system for online information and printed output.
apt-get install openjade              # Implementation of the DSSSL language.
apt-get install jadetex               # Generator of printable output from SGML or XML using Jade.
apt-get install docbook               # Standard SGML representation system for technical documents.
apt-get install docbook2x             # Converts DocBook/XML documents into man pages and TeXinfo.
apt-get install libxml-dom-perl       # Perl module for building DOM Level 1 compliant doc structures.
apt-get install docbook-dsssl         # Modular DocBook DSSSL stylesheets, for print and HTML.

## Drivers
apt-get install plplot12-driver-cairo # Includes pdfcairo
apt-get install plplot12-driver-qt    # Includes pdfqt

# Export plplot version as environment variable.
export PL_VERSION=$PLPLOTVERSION

# Switch to new user's home directory.
cd /home/$NEWUSER 2> /dev/null
if [ 0 -ne $? ]
    then
        echo "Failed to switch to /home/$NEWUSER"
        exit 1
    else
        echo "Switched to /home/$NEWUSER..."
fi

# Make directory for plplot.
mkdir plplot

# Switch to plplot directory.
cd ./plplot 2> /dev/null
if [ 0 -ne $? ]
    then
        echo "Failed to switch to /home/$NEWUSER/plplot"
    else
        echo "Switched to /home/$NEWUSER/plplot..."
fi

# Download plplot.
wget $PLPLOT_URL

tar zxvf plplot-$PL_VERSION.tar.gz

echo ""
echo "Done."
echo ""
# End install