#!/bin/bash
# McEwenGroupPCSetup.sh
# Installs plplot 5.9.9 on Ubuntu 14.04.3 Trusty Tahr
#  The intention here is to make it so that users of
#  Dr. McEwen's research group can use plplot to export
#  graphs in PDF format. There is an option to export
#  graphs in PostScript format, but these typically do
#  not look that great. PDF format is usually preferred.
#
# Written by: Tim Munson (tmunson@wsu.edu)
# Last Updated: 2/9/2016

echo ""

if [ -n "$BASH_VERSION" ]
    then
        echo "Running bash..."
    else
        echo "NOTE: You should run this script with:"
        echo "'bash McEwenGroupPCSetup.sh [NEWUSER]'"
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

if [ -z $1 ]
    then
        echo "ERROR: No username supplied as argument."
        exit 1
    else
        NEWUSER=$1
        echo "Making account $NEWUSER..."
fi

adduser --disabled-password --gecos '' $NEWUSER

### Constants ###
ORIGINAL_WORKING_DIRECTORY=$(pwd)
PLPLOT_URL="http://downloads.sourceforge.net/project/plplot/plplot/5.9.9%20Source/plplot-5.9.9.tar.gz"
PLPLOTVERSION="5.9.9"
CMAKE_VERSION="2.6.0"
CMAKE_URL="http://www.cmake.org/files/v2.6/cmake-$CMAKE_VERSION.tar.gz"

# Begin installation
echo "ORIGINAL_WORKING_DIRECTORY = $ORIGINAL_WORKING_DIRECTORY"
echo "PLPLOT_URL = $PLPLOT_URL"
echo "PLPLOTVERSION = $PLPLOTVERSION"
echo "NEWUSER = $NEWUSER"

# Add './' to PATH environment variable.
export PATH="$PATH:./"

# Update and upgrade.
apt-get -y update
apt-get -y upgrade

# Install g++ (Or else cmake will fail)
apt-get -y install g++

# Install Fortran compiler
apt-get -y install gfortran

## Base/Main.
apt-get -y install libltdl3-dev          # A system independent dlopen wrapper for GNU libtool.
apt-get -y install libqhull-dev          # Calculates convex hulls and related structures.

## Manual.
apt-get -y install texlive-latex-base    # TeX Live: Basic LaTeX packages.
apt-get -y install texinfo               # Documentation system for online information and printed output.
apt-get -y install openjade              # Implementation of the DSSSL language.
apt-get -y install jadetex               # Generator of printable output from SGML or XML using Jade.
apt-get -y install docbook               # Standard SGML representation system for technical documents.
apt-get -y install docbook2x             # Converts DocBook/XML documents into man pages and TeXinfo.
apt-get -y install libxml-dom-perl       # Perl module for building DOM Level 1 compliant doc structures.
apt-get -y install docbook-dsssl         # Modular DocBook DSSSL stylesheets, for print and HTML.

## Drivers.
apt-get -y install plplot12-driver-qt    # Includes pdfqt.
apt-get -y install cl-plplot             # A CFFI based interface to the PLplot scientific plotting library.

apt-get -y install make                  # Install make (needed for cmake and plplot Makefiles).

# Switch pkgconfig directory.
cd $ORIGINAL_WORKING_DIRECTORY/McEwenDependencies/usr/lib/pkgconfig 2> /dev/null
if [ 0 -ne $? ]
    then
        echo "Failed to switch to $ORIGINAL_WORKING_DIRECTORY/McEwenDependencies/usr/lib/pkgconfig"
        exit 1
    else
        echo "Switched to $ORIGINAL_WORKING_DIRECTORY/McEwenDependencies/usr/lib/pkgconfig..."
fi

# Add plplotd-f77.pc to /usr/lib/pkgconfig
cp plplotd-f77.pc /usr/lib/pkgconfig/

# Switch to new user's home directory.
cd /home/$NEWUSER 2> /dev/null
if [ 0 -ne $? ]
    then
        echo "Failed to switch to /home/$NEWUSER"
        exit 1
    else
        echo "Switched to /home/$NEWUSER..."
fi

# Download cmake tarball.
wget $CMAKE_URL
tar xzvf cmake-$CMAKE_VERSION.tar.gz

# Switch to freshly extracted cmake directory.
cd cmake-$CMAKE_VERSION
if [ 0 -ne $? ]
    then
        echo "Failed to switch to /home/$NEWUSER/cmake-$CMAKE_VERSION"
        exit 1
    else
        echo "Switched to /home/$NEWUSER/cmake-$CMAKE_VERSION..."
fi

# Configure and install cmake.
./configure
./bootstrap && make && make install

# Switch to new user's home directory.
cd /home/$NEWUSER 2> /dev/null
if [ 0 -ne $? ]
    then
        echo "Failed to switch to /home/$NEWUSER"
        exit 1
    else
        echo "Switched to /home/$NEWUSER..."
fi

# Export plplot version as environment variable.
export PL_VERSION=$PLPLOTVERSION

# Make directory for plplot.
mkdir plplot

# Switch to plplot directory.
cd ./plplot 2> /dev/null
if [ 0 -ne $? ]
    then
        echo "Failed to switch to /home/$NEWUSER/plplot"
        exit 1
    else
        echo "Switched to /home/$NEWUSER/plplot..."
fi

# Download plplot.
wget $PLPLOT_URL

# Unpack tarball into plplot subdirectory.
tar zxvf plplot-$PL_VERSION.tar.gz

# Create and move into a new subdirectory where the configuration and build steps will be done.
mkdir build_directory
cd build_directory
if [ 0 -ne $? ]
    then
        echo "Failed to switch to /home/$NEWUSER/plplot/build_directory"
        exit 1
    else
        echo "Switched to /home/$NEWUSER/plplot/build_directory..."
fi

# Configure plplot using the cmake application and capture output in the 'cmake.out' file.
cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/$NEWUSER/plplot/install_directory ../plplot-$PL_VERSION >& cmake.out
cat cmake.out

# Build plplot and caputure the resulting output in the cmake.out file.
make VERBOSE=1 >& make.out
cat make.out

# Installs plplot in the /home/$NEWUSER/plplot/install_directory as the install prefix. Capture output in make_install.out file.
make VERBOSE=1 install >& make_install.out
cat make_install.out

echo ""
echo "Done."
echo ""
# End install
