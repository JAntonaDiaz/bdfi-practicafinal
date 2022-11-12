FROM mongo:4.4.0
WORKDIR /main

RUN apt-get update && apt-get upgrade -y

RUN apt-get install git -y && git clone https://github.com/JAntonaDiaz/bdfi-practicafinal.git

WORKDIR /main/bdfi-practicafinal/resources
CMD mongod & ./import_distances.sh
