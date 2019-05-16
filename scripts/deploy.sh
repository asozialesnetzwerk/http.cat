#!/bin/sh

# to run this script you must provide an .env file containing the following
# variables:
#
# DEPLOY_USER=<the username on the remote server> ex. johndoe
# DEPLOY_HOST=<the host of the remote server> ex. example.com
# DEPLOY_DIR=<the deployment directory on the remote machine> ex. /var/www/

set -o nounset
set -o errexit

SOURCE_DIR=build/

# Set the environment by loading from the file "environment" in the same dir
DIR="$( cd "$( dirname $( dirname "$0" ) )" && pwd)"
source "$DIR/.env"

echo "📝 Source: ${DIR}/${SOURCE_DIR}"
echo "🎯 Target: ${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_DIR}"

rsync -rvzp --delete ${SOURCE_DIR} ${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_DIR}

if [ $? -eq 0 ]; then
  echo "✅ Deploy successful!"
else
  echo "❌ Deployment error. Check the output!"
fi
