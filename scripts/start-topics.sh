#!/bin/bash

./bin/kafka-topics.sh --create --bootstrap-server $KAFKA_HOST:$KAFKA_PORT --replication-factor 1 --partitions 1 --topic flight_delay_classification_request
