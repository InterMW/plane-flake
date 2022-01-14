#!/bin/bash
export LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu && /dump1090-mutability/dump1090 --net-only --quiet --net-http-port 80 --rabbit-enable --rabbit-hostname rabbit.centurionx.local --rabbit-port 5672 --rabbit-exchange InterTopic --rabbit-routingkey plane.final --rabbit-user planey --rabbit-password mcplaneyface --write-json-every 1
