# Pull Ubuntu base image.
FROM ubuntu:14.04
MAINTAINER Tim Munson <tmunson@eecs.wsu.edu>

USER root

# Update first
RUN apt-get -qq update

# Install git
RUN apt-get install -qq -y git

# Install other friends
RUN apt-get install -qq -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
	&& rm -rf /var/lib/apt/lists/*

# Change root password to 'a'
RUN echo "root:a" | chpasswd

WORKDIR /root

RUN git clone https://github.com/Munsy/ChebeScripts.git

WORKDIR /root/ChebeScripts/McEwen

RUN bash McEwenGroupPCSetup.sh testuser
