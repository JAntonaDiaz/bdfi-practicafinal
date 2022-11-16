FROM python:3.7
WORKDIR /main

RUN apt-get update && apt-get upgrade -y 

RUN apt-get install git -y && git clone https://github.com/JAntonaDiaz/bdfi-practicafinal.git

WORKDIR /main/bdfi-practicafinal

RUN python3 -m ensurepip --upgrade 
RUN python3 -m pip install --upgrade pip

RUN pip install -r requirements.txt
RUN pip install joblib

WORKDIR /main/bdfi-practicafinal/resources/web

ENTRYPOINT ["python3"]
CMD ["predict_flask.py"]
