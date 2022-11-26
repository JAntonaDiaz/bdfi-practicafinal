#!/bin/bash

python3 /main/bdfi-practicafinal/scripts/mod-kafka.py & sleep 15 
/main/kafka_2.12-3.1.2/bin/kafka-server-start.sh config/server.properties & sleep 10 & ./bin/kafka-topics.sh --create --bootstrap-server $KAFKA_HOST:$KAFKA_PORT --replication-factor 1 --partitions 1 --topic flight_delay_classification_request & sleep infinity
#& sleep 10 && ./bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic flight_delay_classification_request & sleep 12345
