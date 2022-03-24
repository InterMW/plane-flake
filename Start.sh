#!/bin/bash
export LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu && ./dump1090  \
--rabbit-enable --rabbit-hostname rabbit.centurionx.net --rabbit-port 5672 \
--rabbit-exchange InterTopic --rabbit-routingkey plane.proto --rabbit-user planey --rabbit-password mcplaneyface \
--rabbit-source $SOURCE --rabbit-antenna $ANTENNA \
--write-json-every 1 --net$ONLY --interactive  --lat 42.001 --lon -87.6595755 --phase-enhance \
--oversample --interactive-rows 30 --max-range 600 --dcfilter --quiet 

