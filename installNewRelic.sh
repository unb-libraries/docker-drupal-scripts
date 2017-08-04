#!/usr/bin/env sh
# Get latest download URI.
NEWRELIC_DOWNLOAD_FILE=$(curl -s https://download.newrelic.com/php_agent/release/|grep -oP '(?<=/)newrelic-php5-[\d\.]+-linux-musl\.tar\.gz')
NEWRELIC_DOWNLOAD_URI="https://download.newrelic.com/php_agent/release/$NEWRELIC_DOWNLOAD_FILE"
NR_INSTALL_SILENT="true"

# Install Package.
mkdir -p /opt/newrelic
cd /opt/newrelic
wget ${NEWRELIC_DOWNLOAD_URI} -O /opt/newrelic/${NEWRELIC_DOWNLOAD_FILE}
tar -zxf ${NEWRELIC_DOWNLOAD_FILE}
cd /opt/newrelic/newrelic-php5-*
sh newrelic-install install
