FROM openjdk:8-jdk
WORKDIR /main

RUN apt-get update && \
	apt-get upgrade -y

#Descargar Python y PIP
RUN apt install software-properties-common -y && add-apt-repository ppa:deadsnakes/ppa -y
RUN apt install python3 -y 
RUN apt install python3-pip -y  

#Descargar SBT
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee -a /etc/apt/sources.list.d/sbt.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import 
RUN apt-get update && apt-get install sbt

#Descargar Spark
RUN wget https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop2.7.tgz && tar xzvf spark-3.1.2-bin-hadoop2.7.tgz

#Traer repositorio Github
RUN apt-get install git -y && git clone https://github.com/JAntonaDiaz/bdfi-practicafinal.git

WORKDIR /main/bdfi-practicafinal
RUN pip install -r requirements.txt
RUN rm -r models

#Correr SPARK
ENV SPARK_HOME="/main/spark-3.1.2-bin-hadoop2.7"
RUN python3.7 resources/train_spark_mlib_model.py . 
CMD ./spark-3.1.2-bin-hadoop2.7/bin/spark-submit --class es.upm.dit.ging.predictor.MakePrediction --master local --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2 /main/bdfi-practicafinal/flight_prediction/scala-2.12/flight_prediction_2.12-0.1.jar
