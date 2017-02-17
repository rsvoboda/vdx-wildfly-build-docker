FROM rsvoboda/fedora-maven

MAINTAINER Rostislav Svoboda <rsvoboda@redhat.com>

COPY scripts/do-build.sh  /do-build.sh
COPY scripts/settings.xml  /settings.xml
