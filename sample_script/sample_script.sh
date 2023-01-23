#!/bin/sh

# Just a dummy script acting like it's doing something
while true
do
  echo "Act like you are doing something useful"
  curl -H 'Content-type: application/json' -d '{"msg":"stuff stuff stuff"}' $APPLIANCE_TARGET
  sleep 10
done