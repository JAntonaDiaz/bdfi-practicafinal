FROM mongo:4.4.0
WORKDIR /main

RUN apt-get update && apt-get upgrade -y

RUN apt-get install git -y && git clone https://github.com/JAntonaDiaz/bdfi-practicafinal.git

RUN apt-get install -y mongodb-org

CMD ["mongod"]
WORKDIR /main/bdfi-practicafinal
CMD ["./resources/import_distances.sh"]
