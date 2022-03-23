#!/bin/bash
set -euo pipefail

BASE_PATH=/home/vcap/app
export RDECK_BASE=${BASE_PATH}/rundeck

##################################################################################
# Setup ssh key
##################################################################################
echo "-----> Setting SSH key"

if [ -z ${RUNDECK_SSH_KEY+x} ];
then
    echo "       RUNDECK_SSH_KEY is not set, skipping..."
else
    SSH_DIR=/home/vcap/.ssh
    SSH_KEY=${SSH_DIR}/id_rsa
    echo "       RUNDECK_SSH_KEY is set - creating /home/vcap/.ssh/id_rsa"

    mkdir -p $SSH_DIR
    chmod 700 $SSH_DIR

    echo "$RUNDECK_SSH_KEY" > $SSH_KEY
    chmod 600 $SSH_KEY

    echo "    Wrote key to $SSH_KEY"
    cat $SSH_KEY
fi

sleep 2

##################################################################################
# Start Rundeck
##################################################################################
echo "-----> Making java available"
export PATH=$PATH:${BASE_PATH}/.java/bin

if [ -f "${BASE_PATH}/ssl/mysql_truststore" ]; then
    SSL_ARG="-Djavax.net.ssl.trustStore=${BASE_PATH}/ssl/mysql_truststore \
             -Djavax.net.ssl.trustStorePassword=abc123!"
else
    SSL_ARG=""
fi

echo "-----> Starting Rundeck"
JAVA_CALL="java \
    -Dserver.http.port=${PORT} \
    -Dserver.https.port=${PORT} \
    $SSL_ARG \
    -jar $RDECK_BASE/rundeck.war \
    -b $RDECK_BASE \
    --skipinstall"

echo "-----> Executing $JAVA_CALL"
${JAVA_CALL}