#!/bin/sh
cd /usr/local/src/snorby
bundle exec rake snorby:setup
mv -f /start2.sh /start.sh
passenger start -e production 
