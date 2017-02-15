FROM fedora:25

MAINTAINER Rostislav Svoboda <rsvoboda@redhat.com>

RUN dnf install -y java-1.8.0-openjdk-devel maven git && \
    dnf clean all && \
    git --version && \
    mvn -version

