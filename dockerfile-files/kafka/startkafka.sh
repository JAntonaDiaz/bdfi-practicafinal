#!/bin/bash

./bin/kafka-server-start.sh config/server.properties &

./bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic flight_delay_classification_request
