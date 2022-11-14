FROM openjdk:8-jdk
WORKDIR /main

RUN apt-get update && apt-get upgrade -y
RUN apt-get install git -y && git clone https://github.com/JAntonaDiaz/bdfi-practicafinal.git

RUN wget https://archive.apache.org/dist/kafka/3.1.2/kafka_2.12-3.1.2.tgz && tar -xzf kafka_2.12-3.1.2.tgz

#RUN chmod +x bdfi-practicafinal/dockerfile-files/kafka/startkafka.sh
#WORKDIR /main/bdfi-practicafinal/dockerfile-files/kafka
#WORKDIR /main/bdfi-practicafinal/dockerfile-files/kafka
EXPOSE 9092

CMD sh ./bdfi-practicafinal/dockerfile-files/kafka/startkafka.sh

