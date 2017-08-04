#!/usr/bin/env sh
# Get latest download URI.
NEWRELIC_DOWNLOAD_FILE=$(curl -s http://download.newrelic.com/php_agent/release/ | sed -rn 's/.*(newrelic-php5-[0-9.]+-linux-musl\.tar\.gz).*/\1/p')
NEWRELIC_DOWNLOAD_URI="http://download.newrelic.com/php_agent/release/$NEWRELIC_DOWNLOAD_FILE"
NR_INSTALL_SILENT="true"

# Install Package.
mkdir -p /opt/newrelic
cd /opt/newrelic
wget ${NEWRELIC_DOWNLOAD_URI} -O /opt/newrelic/${NEWRELIC_DOWNLOAD_FILE}
tar -zxf ${NEWRELIC_DOWNLOAD_FILE}
cd /opt/newrelic/newrelic-php5-*
sh newrelic-install install
