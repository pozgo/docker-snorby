FROM centos:centos7
MAINTAINER Przemyslaw Ozgo <linux@ozgo.info>

RUN \
    yum update -y && \
    yum install -y epel-release && \
    yum install -y tar wget git libxml2-devel libxslt-devel mariadb mariadb-devel wkhtmltopdf && \
     # Prepare ruby for Snorby
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -sSL https://get.rvm.io | bash -s stable --ruby=1.9.3 && \
    source /usr/local/rvm/scripts/rvm && \
    source /etc/profile.d/rvm.sh && \
    export PATH=$PATH:/usr/local/rvm/rubies/ruby-1.9.3-p551/bin && \
    gem update --system && \
    gem install bundler && \
    # Install DAQ and Snort
    yum install -y https://www.snort.org/downloads/snort/daq-2.0.4.centos7.x86_64.rpm && \
    yum install -y https://www.snort.org/downloads/snort/snort-2.9.7.0-1.centos7.x86_64.rpm && \
    # Install Community rules
    wget -O /tmp/community-rules.tar.gz https://www.snort.org/downloads/community/community-rules.tar.gz && \
    mkdir -p /etc/snort/rules && \
    tar zxvf /tmp/community-rules.tar.gz -C /etc/snort/rules --strip-components=1 && \
    rm -f /tmp/community-rules.tar.gz && \
    # Get Latest Snorby
    git clone git://github.com/Snorby/snorby.git /usr/local/src/snorby && \
    cd /usr/local/src/snorby && bundle install

COPY container-files /

ENV DB_ADDRESS=127.0.0.1 DB_USER=user DB_PASS=password SNORBY_CONFIG=/usr/local/src/snorby/config/snorby_config.yml OINKCODE=community

ENTRYPOINT ["/bootstrap.sh"]