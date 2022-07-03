#!/bin/bash
export LD_LIBRARY_PATH=/usr/local/lib/arm-linux-gnueabihf && /dump1090-mutability/dump1090  \
--rabbit-enable --rabbit-hostname rabbit.centurionx.net --rabbit-port 5672 \
--rabbit-exchange InterTopic --rabbit-routingkey plane.proto --rabbit-user $RABBITUSER --rabbit-password $RABBITPASS \
--rabbit-source $SOURCE --rabbit-antenna $ANTENNA \
--write-json-every 1 --net --phase-enhance \
--oversample --interactive-rows 30 --max-range 600 --dcfilter --quiet 
