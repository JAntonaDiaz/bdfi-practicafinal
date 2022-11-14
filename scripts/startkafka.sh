#!/bin/bash
sleep 7;
./bin/kafka-server-start.sh config/server.properties & sleep 10;

./bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic flight_delay_classification_request

#./bin/kafka-server-start.sh config/server.properties
