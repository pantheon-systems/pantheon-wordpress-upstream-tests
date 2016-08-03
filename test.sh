#!/bin/bash

###
# Execute the Behat test suite against a prepared Pantheon site environment.
###

set -ex


./vendor/bin/behat $*
