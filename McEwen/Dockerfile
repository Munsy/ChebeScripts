# Pull Ubuntu base image.
FROM ubuntu:14.04
MAINTAINER Tim Munson <tmunson@eecs.wsu.edu>

USER root

# Add old PlPlot dependencies to /etc/apt/sources.list
RUN printf "\n## PLPlot and friends\ndeb http://mirrors.kernel.org/ubuntu/ precise main universe\n" >> /etc/apt/sources.list

# Update
RUN apt-get -qq update

# Install friends
RUN apt-get install -qq -y wget g++ make gfortran

# Set D compiler to ldc
ENV DC ldc

RUN apt-get -y -qq install libplplot11
RUN apt-get -y -qq install libplplot-dev=5.9.9-2ubuntu2
RUN apt-get -y -qq install plplot11-driver-qt

# Fix symbolic link issues
RUN ln -s /lib/x86_64-linux-gnu/libm.so.6 /usr/lib/libm.so

# Download, extract and install CMake v2.6.4
WORKDIR /opt
RUN wget http://www.cmake.org/files/v2.6/cmake-2.6.4.tar.gz
RUN tar xzvf cmake-2.6.4.tar.gz
WORKDIR /opt/cmake-2.6.4
RUN ./configure && make && make install

# Download, extract and install PLPlot v5.9.9
WORKDIR /opt
RUN wget http://downloads.sourceforge.net/project/plplot/plplot/5.9.9%20Source/plplot-5.9.9.tar.gz
RUN tar xzvf plplot-5.9.9.tar.gz
RUN mkdir build_directory
WORKDIR /opt/build_directory
RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/plplot/install_directory /opt/plplot-5.9.9
RUN make VERBOSE=1
RUN make VERBOSE=1 install
