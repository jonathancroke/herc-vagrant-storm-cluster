#!/bin/sh
JAVA_BIN=jdk-6u45-linux-i586.bin
JAVA_VERSION=jdk1.6.0_45
export PATH=/usr/bin:/bin:/usr/sbin:/sbin
echo "Installing JDK"
chmod 775 /vagrant_data/$JAVA_BIN
TMP=`mktemp -d`
cd $TMP
/vagrant_data/$JAVA_BIN
sudo mv $JAVA_VERSION /opt
sudo ln -s /opt/$JAVA_VERSION /opt/java
sudo update-alternatives --install /usr/bin/java java /opt/java/bin/java 0
sudo update-alternatives --install /usr/bin/javac javac /opt/java/bin/javac 0
sudo update-alternatives --install /usr/bin/javah javah /opt/java/bin/javah 0
sudo update-alternatives --install /usr/bin/jar jar /opt/java/bin/jar 0
sudo update-alternatives --install /usr/bin/javadoc javadoc /opt/java/bin/javadoc 0
