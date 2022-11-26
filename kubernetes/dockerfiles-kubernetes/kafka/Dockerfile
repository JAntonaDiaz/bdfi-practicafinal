FROM openjdk:8-jdk
WORKDIR /main

RUN apt-get update && apt-get upgrade -y
RUN apt-get install git -y && git clone https://github.com/JAntonaDiaz/bdfi-practicafinal.git
RUN apt install software-properties-common -y && add-apt-repository ppa:deadsnakes/ppa -y
RUN apt install python3 -y

RUN wget https://archive.apache.org/dist/kafka/3.1.2/kafka_2.12-3.1.2.tgz && tar -xzf kafka_2.12-3.1.2.tgz

WORKDIR /main/kafka_2.12-3.1.2


#CMD ./bin/kafka-server-start.sh config/server.properties
CMD sh ./../bdfi-practicafinal/scripts/startkafka.sh

