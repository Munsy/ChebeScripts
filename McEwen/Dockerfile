# Pull Ubuntu base image.
FROM ubuntu:14.04
MAINTAINER Tim Munson <tmunson@eecs.wsu.edu>

USER root

# Update first
RUN apt-get -qq update

# Install cURL
RUN apt-get install -qq -y curl

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

RUN curl https://raw.githubusercontent.com/Munsy/ChebeScripts/master/McEwenGroupPCSetup.sh

RUN bash McEwenGroupPCSetup.sh
