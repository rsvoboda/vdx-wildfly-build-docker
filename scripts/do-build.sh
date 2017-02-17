#!/bin/bash 

if [ ! -d "/checkouts" ]; then
    echo "No checkouts folder was exists so creating a temp one. To cache this in the furure between all jobs:"
    echo " Map your local directory into the docker image. Another option is to create a persistent docker volume."
    echo "  -v ~/Downloads/vdx-wildfly-build-repos:/checkouts"
    echo " "
    mkdir /checkouts
fi

echo " ...  VDX  ... "
cd /checkouts
if [ ! -d "/checkouts/vdx" ]; then
    git clone https://github.com/projectodd/vdx.git
    cd vdx
else
    cd vdx
    git pull
fi
mvn -Dmaven.repo.local=/checkouts/local-repo clean install 
mvn help:evaluate -Dexpression=project.version
VDX_VERSION=`mvn help:evaluate -Dexpression=project.version | grep -v '^\['`
echo "VDX_VERSION is ${VDX_VERSION}"


echo " ...  WF CORE  ... "
cd /checkouts
if [ ! -d "/checkouts/wildfly-core" ]; then
    git clone https://github.com/wildfly/wildfly-core.git
    cd wildfly-core
else
    cd wildfly-core
    git pull
fi
mvn -s /settings.xml -Dmaven.repo.local=/checkouts/local-repo -Dversion.org.projectodd.vdx=${VDX_VERSION} clean install -DskipTests -Denforcer.skip=true -Dcheckstyle.skip=true
mvn help:evaluate -Dexpression=project.version
CORE_VERSION=`mvn help:evaluate -Dexpression=project.version | grep -v "^\["`
echo "CORE_VERSION is ${CORE_VERSION}"


echo " ...  WILDFLY  ... "
cd /checkouts
if [ ! -d "/checkouts/wildfly" ]; then
    git clone https://github.com/wildfly/wildfly.git
    cd wildfly
else
    cd wildfly
    git pull
fi
mvn -s /settings.xml -Dmaven.repo.local=/checkouts/local-repo -Dversion.org.wildfly.core=${CORE_VERSION} clean install -DskipTests -Denforcer.skip=true -Dcheckstyle.skip=true

echo ""
echo "Build done, look at wildfly/dist/target of the mapped local directory"
echo 'You may want fix ownership, run this: sudo chown -R $USER:$USER /path/to/mapped/local/directory'

