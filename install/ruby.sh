#!/bin/sh

set -e

echo "Installing Ruby..."

# Install ruby-build
git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build
cd /tmp/ruby-build
./install.sh

# Build ruby 2.1
CONFIGURE_OPTS="--disable-install-rdoc" ruby-build 1.9.3-p547 /usr/local
cd / && rm -rf /tmp/ruby-build*

echo 'gem: --no-document' > /etc/gemrc
gem update --system
gem install bundler