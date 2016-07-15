#!/bin/bash

###
# Prepare a Pantheon site environment for the Behat test suite, by pushing the
# requested upstream branch to the environment. This script is architected
# such that it can be run a second time if a step fails.
###

set -ex

if [ -z "$TERMINUS_SITE" ] || [ -z "$TERMINUS_ENV" ]; then
	echo "TERMINUS_SITE and TERMINUS_ENV environment variables must be set"
	exit 1
fi

###
# Create a new environment for this particular test run.
###
terminus site create-env --to-env=$TERMINUS_ENV --from-env=dev
yes | terminus site wipe

###
# Get all necessary environment details.
###
PANTHEON_GIT_URL=$(terminus site connection-info --field=git_url)
PANTHEON_SITE_URL="$TERMINUS_ENV-$TERMINUS_SITE.pantheonsite.io"
PREPARE_DIR="/tmp/$TERMINUS_ENV-$TERMINUS_SITE"
BASH_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

###
# Switch to git mode for pushing the files up
###
terminus site set-connection-mode --mode=git
rm -rf $PREPARE_DIR
# git clone -b $TERMINUS_ENV $PANTHEON_GIT_URL $PREPARE_DIR

###
# Push the upstream branch to the environment
###


###
# Switch to SFTP mode so the site can install plugins and themes
###
terminus site set-connection-mode --mode=sftp
