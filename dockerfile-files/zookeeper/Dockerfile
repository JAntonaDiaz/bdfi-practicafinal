FROM openjdk:8-jdk
WORKDIR /main

RUN apt-get update && apt-get upgrade -y

RUN wget https://archive.apache.org/dist/kafka/3.1.2/kafka_2.12-3.1.2.tgz && tar -xzf kafka_2.12-3.1.2.tgz

WORKDIR /main/kafka_2.12-3.1.2

CMD bin/zookeeper-server-start.sh config/zookeeper.properties
