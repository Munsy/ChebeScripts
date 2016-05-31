# Pull Ubuntu base image.
FROM ubuntu:14.04
MAINTAINER Tim Munson <tmunson@eecs.wsu.edu>

USER root

# Update
RUN apt-get -qq update

# Install friends
RUN apt-get install -qq -y wget gcc g++ make language-pack-en-base

WORKDIR /opt

RUN wget https://s3.amazonaws.com/pe-builds/released/2016.1.2/puppet-enterprise-2016.1.2-ubuntu-14.04-amd64.tar.gz

RUN tar xvzf puppet-enterprise-2016.1.2-ubuntu-14.04-amd64.tar.gz

WORKDIR /opt/puppet-enterprise-2016.1.2-ubuntu-14.04-amd64

RUN echo "export PATH=$PATH:./" >> ~/.bashrc

RUN echo export PATH="$PATH:./"

RUN echo "export LANG=en_US.UTF-8" >> ~/.bashrc
RUN echo "export LANGUAGE=en_US.UTF-8" >> ~/.bashrc
RUN echo "export LC_ALL=en_US.UTF-8" >> ~/.bashrc

EXPOSE 22 80 3000 5432 8080

