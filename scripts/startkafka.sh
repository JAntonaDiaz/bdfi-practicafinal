#!/bin/bash

python3 ../scripts/mod-kafka.py & sleep 15 & ./bin/kafka-server-start.sh config/server.properties 

#& sleep 10 && ./bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic flight_delay_classification_request & sleep 12345
