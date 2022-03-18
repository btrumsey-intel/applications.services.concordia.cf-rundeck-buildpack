#!/bin/bash
set -euo pipefail

BASE_PATH=/home/vcap/app
export RDECK_BASE=${BASE_PATH}/rundeck

echo "-----> Making java available"
export PATH=$PATH:${BASE_PATH}/.java/bin

if [ -f "${BASE_PATH}/ssl/mysql_truststore" ]; then
    SSL_ARG="-Djavax.net.ssl.trustStore=${BASE_PATH}/ssl/mysql_truststore \
             -Djavax.net.ssl.trustStorePassword=abc123"
else
    SSL_ARG=""
fi

echo "-----> Starting Rundeck"
JAVA_CALL="java \
    -jar $RDECK_BASE/rundeck.war \
    -Dserver.https.port=${PORT} \
    -Dserver.http.port=${PORT} \
    -b $RDECK_BASE \
    $SSL_ARG \
    --skipinstall" \

echo "-----> Executing $JAVA_CALL"
${JAVA_CALL}