FROM polinux/centos7:base
MAINTAINER Przemyslaw Ozgo <linux@ozgo.info>

# - You will need /polinux/idsdb:base container to be running on the same host. 
# - Installing Daq and Snort interpreters
RUN \
yum update -y && \
yum install -y --nogpgcheck flex bison make gcc gcc-c++ libpcap-devel pcre-devel libdnet-devel zlib-devel libtool mariadb mariadb-devel git java-1.7.0-openjdk libxml2-devel libxslt-devel ImageMagick-devel && \
mkdir /root/workdir/ && \
cd /root/workdir/ && \
wget https://www.snort.org/downloads/snort/daq-2.0.2.tar.gz && \
tar zxvf daq-2.0.2.tar.gz && \
cd daq-2.0.2/  && \
./configure && \
make  && \
make install && \
cd .. && \
wget https://www.snort.org/downloads/snort/snort-2.9.6.2.tar.gz && \
tar zxvf snort-2.9.6.2.tar.gz && \
cd snort-2.9.6.2/ && \
./configure --enable-sourcefire && \
make  && \
make install 

# - Installing Snorby on rails
# - create database with those details on localhost or use polinux/db:base container and setup database.
# - DBName:     snorby
# - Username:   snorbyuser
# - Password:   password


ADD install /usr/local/install
RUN \
cd /usr/local/install &&\
chmod +x /usr/local/install/ruby.sh && \
./ruby.sh

RUN \
cd /usr/local/src/ && \
git clone git://github.com/Snorby/snorby.git

ADD config/ /usr/local/src/snorby/config/

RUN \ 
cd /usr/local/install &&\
chmod +x /usr/local/install/install_snorby.sh && \
./install_snorby.sh

RUN \
mv /usr/local/install/start.sh / &&\
mv /usr/local/install/start2.sh / 

ADD supervisord.conf /etc/supervisord.d/snorby.conf