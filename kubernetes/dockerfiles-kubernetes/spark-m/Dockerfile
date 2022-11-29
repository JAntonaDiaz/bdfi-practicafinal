FROM openjdk:8-jdk

WORKDIR /main
RUN apt-get update && apt-get upgrade -y

#Descargar Python y PIP
RUN apt install software-properties-common -y && add-apt-repository ppa:deadsnakes/ppa -y
RUN apt install python3 -y 
RUN apt install python3-pip -y

#Traer repositorio Github
RUN apt-get install git -y && git clone https://github.com/JAntonaDiaz/bdfi-practicafinal.git

WORKDIR /main/bdfi-practicafinal
RUN pip install -r requirements.txt

# Descargar Spark
WORKDIR /main
RUN wget https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop2.7.tgz && tar xzvf spark-3.1.2-bin-hadoop2.7.tgz

WORKDIR /main/spark-3.1.2-bin-hadoop2.7/sbin

ENV SPARK_WORKER_INSTANCES=1
ENV SPARK_WORKER_CORES=1
ENV SPARK_EXECUTOR_CORES=1

CMD ./start-master.sh & ./start-worker.sh spark://localhost:7077 & ../bin/spark-submit --master spark://localhost:7077 --class "es.upm.dit.ging.predictor.MakePrediction" --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2 /main/bdfi-practicafinal/flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar
