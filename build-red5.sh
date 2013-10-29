#!/bin/bash

set -x

RED5_SRC=$(pwd)
NEW_RED5=/usr/share/red5-r4729
RED5_VER=1.0.2-RC3

echo "Preparing build"
mvn clean

echo "mvn bootstrap install"
mvn -Dmaven.test.skip=true -Dclassifier=bootstrap install
echo "mvn dependencies"
mvn dependency:copy-dependencies
echo "mvn package"
mvn -Dmaven.test.skip=true -Dclassifier=bootstrap package

cd $RED5_SRC/target
echo "Extractring red5"
tar zxvf red5-server-${RED5_VER}-server.tar.gz

mv red5-server-${RED5_VER} red5-server
cp $RED5_SRC/extras/commons-fileupload-1.2.2.jar red5-server/lib
cp $RED5_SRC/extras/commons-io-2.1.jar red5-server/lib

echo "Done."
cd $RED5_SRC

