#!/bin/bash
./dump1090  \
--rabbit-enable --rabbit-hostname rabbit.centurionx.net --rabbit-port 5672 \
--fix \
--rabbit-exchange InterTopic --rabbit-routingkey plane.proto \
--rabbit-user $RABBITUSER --rabbit-password $RABBITPASS \
--rabbit-source $SOURCE --rabbit-antenna $ANTENNA \
--write-json-every 1 --net$ONLY \
--net-bind-address 0.0.0.0 \
--quiet 

