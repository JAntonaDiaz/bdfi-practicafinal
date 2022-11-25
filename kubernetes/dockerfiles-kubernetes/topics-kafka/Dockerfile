FROM openjdk:8-jdk
WORKDIR /main

RUN apt-get update && apt-get upgrade -y
RUN apt-get install git -y && git clone https://github.com/JAntonaDiaz/bdfi-practicafinal.git

RUN wget https://archive.apache.org/dist/kafka/3.1.2/kafka_2.12-3.1.2.tgz && tar -xzf kafka_2.12-3.1.2.tgz

WORKDIR /main/kafka_2.12-3.1.2

#CMD ./bin/kafka-topics.sh --create --bootstrap-server $KAFKA_HOST:9092 --replication-factor 1 --partitions 1 --topic flight_delay_classification_request
CMD sh ./../bdfi-practicafinal/scripts/start-topics.sh
