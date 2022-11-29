FROM openjdk:8-jdk

WORKDIR /main
RUN apt-get update && apt-get upgrade -y

# Descargar Spark
RUN wget https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop2.7.tgz && tar xzvf spark-3.1.2-bin-hadoop2.7.tgz

WORKDIR /main/spark-3.1.2-bin-hadoop2.7/sbin

ENV SPARK_WORKER_INSTANCES=1
ENV SPARK_WORKER_CORES=1
ENV SPARK_EXECUTOR_CORES=1

CMD ./start-worker.sh spark://instance-bdfi-proyecto-final.europe-southwest1-a.c.bdfi-367411.internal:7077 & sleep infinity