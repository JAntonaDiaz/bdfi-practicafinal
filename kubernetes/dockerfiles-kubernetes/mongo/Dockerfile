FROM mongo:4.4
WORKDIR /main

RUN apt-get update && apt-get upgrade -y

RUN apt-get install git -y && git clone https://github.com/JAntonaDiaz/bdfi-practicafinal.git

WORKDIR /main/bdfi-practicafinal

CMD mongod --bind_ip_all & ./resources/import_distances.sh & sleep infinity
