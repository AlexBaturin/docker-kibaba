#!/bin/bash
set -m
RET=1
while [[ RET -ne 0 ]]; do
   echo "Stalling for Elasticsearch..."
   curl -XGET -k -u "$ELASTIC_USER:$ELASTIC_PASSWD" "http://$ELASTIC_HOST:$ELASTIC_PORT/" >/dev/null 2>&1
   RET=$?
   sleep 5
done

if [ "$1" = 'kibana' ]; then
	set -- gosu kibana tini -- "$@"
fi
$@ &
fg
