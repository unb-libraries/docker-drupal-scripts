#!/usr/bin/env sh
set -e

# Dev/NoDev
DRUPAL_COMPOSER_DEV="${1:-no-dev}"

# Copy build files into a temporary build location.
mkdir ${DRUPAL_BUILD_TMPROOT}
cp ${TMP_DRUPAL_BUILD_DIR}/composer.json ${DRUPAL_BUILD_TMPROOT}

# Change to the build directory
cd ${DRUPAL_BUILD_TMPROOT}

# Get latest composer/ScriptHandler.php.
mkdir -p scripts/composer
curl -O https://raw.githubusercontent.com/drupal-composer/drupal-project/8.x/scripts/composer/ScriptHandler.php
mv ScriptHandler.php scripts/composer/

# Build instance.
echo "Building - 'composer install --prefer-dist --${DRUPAL_COMPOSER_DEV}'"
composer install --no-ansi --prefer-dist --${DRUPAL_COMPOSER_DEV}

# Check if drush install version matches upstream
if [ ! -d "/opt/drush/$DRUSH_INSTALL_VERSION" ]; then
  # Remove upstream version.
  rm -rf /opt/drush
  rm -rf /usr/bin/drush*

  # Install new version.
  echo "Installing Drush $DRUSH_INSTALL_VERSION"
  cd /app
  COMPOSER_HOME=/opt/drush COMPOSER_BIN_DIR=/usr/bin COMPOSER_VENDOR_DIR=/opt/drush/$DRUSH_INSTALL_VERSION composer require drush/drush:$DRUSH_INSTALL_VERSION --no-ansi --prefer-dist
  mv /usr/bin/drush.php /usr/bin/drush
  cd /opt/drush/$DRUSH_INSTALL_VERSION/drush/drush
  composer update
fi

# Remove composer cache
rm -rf /root/.composer/cache

# Make drupal console available.
ln -s ${DRUPAL_BUILD_TMPROOT}/vendor/bin/drupal /usr/bin/drupal

# Move profile from repo to build root.
cd ${DRUPAL_BUILD_TMPROOT}
mv ${TMP_DRUPAL_BUILD_DIR}/${DRUPAL_SITE_ID} ${DRUPAL_BUILD_TMPROOT}/profiles/

# Copy config from standard install profile for current version of Drupal.
cp -r ${DRUPAL_BUILD_TMPROOT}/core/profiles/standard/config ${DRUPAL_BUILD_TMPROOT}/profiles/${DRUPAL_SITE_ID}/

# Move settings files into build location.
mkdir -p ${DRUPAL_BUILD_TMPROOT}/sites/all
mv ${TMP_DRUPAL_BUILD_DIR}/settings ${DRUPAL_BUILD_TMPROOT}/sites/all/
