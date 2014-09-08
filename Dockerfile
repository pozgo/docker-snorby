FROM polinux/centos7:latest
MAINTAINER Przemyslaw Ozgo <linux@ozgo.info>

# - You will need database container to be running on the same host. 
# - Installing Daq and Snort interpreters

ADD install /data/install

RUN yum update -y && \
yum install -y --nogpgcheck flex bison make gcc gcc-c++ libpcap-devel pcre-devel libdnet-devel zlib-devel libtool mariadb mariadb-devel git java-1.7.0-openjdk libxml2-devel libxslt-devel ImageMagick-devel && \
yum clean all && \
mkdir /root/workdir/ && \
cd /root/workdir/ && \
wget https://www.snort.org/downloads/snort/daq-2.0.2.tar.gz && \
tar zxvf daq-2.0.2.tar.gz && \
rm daq-2.0.2.tar.gz && \
cd daq-2.0.2/  && \
./configure && \
make  && \
make install && \
cd .. && \
rm -rf daq-2.0.2/ && \
wget https://www.snort.org/downloads/snort/snort-2.9.6.2.tar.gz && \
tar zxvf snort-2.9.6.2.tar.gz && \
rm snort-2.9.6.2.tar.gz && \
cd snort-2.9.6.2/ && \
./configure --enable-sourcefire && \
make  && \
make install && \
cd .. && \
rm -rf snort-2.9.6.2/ && \
cd /data/install &&\
chmod +x /data/install/ruby.sh && \
./ruby.sh && \
cd /usr/local/src/ && \
git clone git://github.com/Snorby/snorby.git && \
cd /data/install &&\
chmod +x /data/install/install_snorby.sh && \
./install_snorby.sh && \
mv /data/install/start.sh / && \
mv /data/install/start2.sh / && \
mv /data/install/database.yml /usr/local/src/snorby/config/database.yml && \
mv /data/install/snorby_config.yml /usr/local/src/snorby/config/snorby_config.yml  

ADD supervisord.conf /etc/supervisord.d/snorby.conf