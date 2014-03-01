############################################################
# Dockerfile to build MongoDB container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu 12.04 LTS
FROM    ubuntu:12.04

# File Author / Maintainer
MAINTAINER rudijs <ooly.me@gmail.com>

# Update the repository sources list, update and upgrade
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

RUN apt-get update

RUN apt-get upgrade -y

#############
# Supervisord
#############

RUN apt-get install -y supervisor

######
# Sudo
######

RUN apt-get install -y sudo

# Configure sudo
RUN echo '%sudo   ALL=NOPASSWD: ALL' >> /etc/sudoers

####################################
# SSH Server and User Account Set Up
####################################

RUN apt-get install -y pwgen openssh-server supervisor

# Configure sshd and start up
RUN mkdir /var/run/sshd
RUN sed -i.bak s/PermitRootLogin\ yes/PermitRootLogin\ no/ /etc/ssh/sshd_config
ADD ./supervisord_sshd.conf /etc/supervisor/conf.d/sshd.conf

# SSH User Account
ADD ./ssh_user_account.sh /root/ssh_user_account.sh

#############
# Chef Client
#############

RUN apt-get install -y curl

RUN curl -L https://www.opscode.com/chef/install.sh | sudo bash

####################
# Container Start Up
####################

# Script to add user and copy supervisord configs
ADD ./start.sh /root/start.sh

# Set as executable
RUN chmod 755 /root/*.sh

ENTRYPOINT ["/bin/bash", "-c", "/root/start.sh"]
