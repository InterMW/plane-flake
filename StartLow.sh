#!/bin/bash
./dump1090  \
--rabbit-enable --rabbit-hostname rabbit.centurionx.net --rabbit-port 5672 \
--fix \
--rabbit-exchange InterTopic --rabbit-routingkey plane.proto \
--rabbit-user $RABBITUSER --rabbit-password $RABBITPASS \
--rabbit-source $SOURCE --rabbit-antenna $ANTENNA \
--write-json-every 1 --net$ONLY --lat 42.001 --lon -87.6595755 \
--quiet 

