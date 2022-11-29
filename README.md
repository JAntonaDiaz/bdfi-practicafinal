# Práctica BDFI: Predicción de retraso de vuelos

Para construir este sistema, se tiene un dataset que contiene información de vuelos pasados, incluyendo si han salido con retraso o no. A partir de esta información queremos predecir si va a haber retrasos en un vuelo futuro. Para ello, entrenamos un modelo predictivo basado en el algoritmo RandomForest con los datos.
Gracias al despliegue de una arquitectura completa, utilizaremos el modelo predictivo que hemos creado y podremos realizar predicciones en tiempo real para nuevos vuelos. 


## Arquitectura del sistema y versiones
La arquitectura del escenario completo es la que se muestra a continuación:
[<img src="images/video_course_cover.png">](http://datasyndrome.com/video)

Para que el sistema funcione correctamente, se necesita compatibilidad entre las versiones de los distintos componentes software. Por ello, para el despliegue del escenario se han utilizado las siguientes versiones:
 - [Intellij](https://www.jetbrains.com/help/idea/installation-guide.html) (jdk_1.8) *solo usado para el primer hito
 - [Pyhton3](https://realpython.com/installing-python/) (version 3.7) 
 - [PIP](https://pip.pypa.io/en/stable/installing/)(version 20.0.2)
 - [SBT](https://www.scala-sbt.org/release/docs/Setup.html) (version 1.8.0)
 - [Scala](https://www.scala-lang.org)(version 2.12.10)
 - [Zookeeper](https://zookeeper.apache.org/releases.html) (PONER VERSION, VER EN LA MV)
 - [Kafka](https://kafka.apache.org/quickstart) (PONER VERSION, VER EN LA MV)
 - [MongoDB](https://docs.mongodb.com/manual/installation/)(version 4.4)
 - [Spark](https://spark.apache.org/docs/latest/) (version 3.1.2)

### Procesos del sistema
1. Descargar los datos de vuelos pasados.
2. Entrenar el modelo de ML utilizando los datos de vuelos usando PySpark.
3. Desplegar el job de Spark que predice el retraso de los vuelos utilizando el modelo creado.
4. A través de una interfaz web, el usuario introducirá los datos del vuelo a predecir y se enviarán al servidor web de Flask.
5. El servidor web enviará esos datos al job a través de Kafka.
6. El job realizará la predicción y la guardará en Mongo.
7. La interfaz web estará constantemente haciendo polling para comprobar si ya está realizada la predicción y en caso afirmativo, muestra la predicción por la interfaz.

## Hitos conseguidos
- Lograr el funcionamiento de la práctica sin realizar modificaciones.
- Ejecución del job de predicción con Spark Submit en vez de IntelliJ.
- Dockerizar cada uno de los servicios que componen la arquitectura completa.
- Desplegar el escenario completo usando docker-compose.
- Desplegar el escenario completo usando kubernetes.
- Desplegar el escenario completo en una máquina virtual en Google Cloud accediendo a su interfaz gráfica con el gestor NoMachine.
- Cargar las imágenes de los contenedores en el Container Registry de Google Cloud.

## Funcionamiento de la práctica sin realizar modificaciones
Para realizar este hito, se ha utilizado el repositorio utilizado en el enunciado, https://github.com/ging/practica_big_data_2019, y se ha seguido su README.md.
## Ejecución del job de predicción con Spark Submit
Cuando despliegas con IntelliJ despliegas el job desde el IDE sin indicar ninguna linea específica de ejecución, por lo que toma por defecto las opciones que se necesitarían para ejecutar el programa, siendo innecesario generar ningun paquete con sbt directamente debido a que el IDE identifica cual es el main class dentro del código fuente. 
Por otra parte spark-submit, usa como entorno de ejecución la instancia de spark que tienes instalada ya sea de forma local o remota y para ellos debes indicarle donde puede encontrar el fichero empaquetado con sbt en donde se encuentra el main class. En resumen, la ejecución con intelijj solo usa los binarios de spark para ejecutar todo de forma local. Mientras que con spark submit puedes usar cualquier instancia de spark para desplegar el código de la aplicación ya sea de forma local o remota y así aprovechar las ventajas de distribución de la herramienta.  
Partiendo del hito anterior, se va a utilizar sbt, una herramienta de compilación de código abierto para proyectos Scala y Java, similar a Maven.  
Para utilizar spark-submit es necesario generar un fichero empaquetado .jar donde se encuentre el main class del código. Este fichero se genera accediendo al directorio *bdfi-practicafinal/flight_prediction* y ejecutando los siguientes comandos:
```
sbt clean
sbt package
```
el .jar estará situado en *bdfi-practicafinal/flight_prediction/target/scala-2.12*.
Por último, para arrancar el Spark en local utilizaremos el siguiente comando:
```
./../spark-3.1.2-bin-hadoop2.7/bin/spark-submit --class es.upm.dit.ging.predictor.MakePrediction --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2 /main/bdfi-practicafinal/flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar
```
*NOTA: el comando anterior incluye paquetes para que el spark pueda conectarse a Kafka y a Mongo y poder realizar el flujo del sistema.* 
## Dockerización de los servicios
## Despliegue con DOCKER-COMPOSE
Hablar de los workers aquí
## Despliegue con KUBERNETES
### Obtención de los ficheros service.yaml y deployment.yaml
Partiendo del docker-compose.yaml creado en el hito anterior, se ha utilizado la herramienta [Kompose](https://kompose.io/). Esta herramienta permite obtener los archivos necesarios para desplegar el escenario con Kubernetes a partir del docker-compose.

Por ello, una vez instalado Kompose, ejecutando el comando:
```
kompose convert
```
en el mismo directorio en el que se encuentra el docker-compose.yaml, generando los disintos x-service.yaml y x-deployment.yaml que hemos agrupado en los ficheros services.yaml y deployment.yaml.

El resultado del comando anterior es el siguiente:
```
INFO Kubernetes file "flask-server-service.yaml" created 
INFO Kubernetes file "kafka-service.yaml" created 
INFO Kubernetes file "mongo-service.yaml" created 
INFO Kubernetes file "spark-service.yaml" created 
INFO Kubernetes file "worker1-service.yaml" created 
INFO Kubernetes file "worker2-service.yaml" created 
INFO Kubernetes file "zookeeper-service.yaml" created 
INFO Kubernetes file "flask-server-deployment.yaml" created 
INFO Kubernetes file "kafka-deployment.yaml" created 
INFO Kubernetes file "mongo-deployment.yaml" created 
INFO Kubernetes file "spark-deployment.yaml" created 
INFO Kubernetes file "worker1-deployment.yaml" created 
INFO Kubernetes file "worker2-deployment.yaml" created 
INFO Kubernetes file "zookeeper-deployment.yaml" created 
```

No obstante, cabe señalar que los servicios se encuentran configurados como ClusterIP, por lo que desde el exterior no podríamos acceder el servidor Flask. Por ello, es necesario cambiar el tipo de servicio del servidor Flask a NodePort, permitiendo así que al exponer una dirección IP estática externa para el cluster, a través del puerto 30500 podamos acceder al interfaz web.
*NOTA: el rango de puertos elegibles de tipo NodePort es entre el 30000-32767*
### Modificación de ficheros del proyecto
Debido a que ya no se despliegan los contenedores en el mismo ordenador, hay que modificar los ficheros que utilizan los distintos componentes para conectarse entre sí ya que por defecto se conectan todos a *localhost:puerto_servicio*. 
Los ficheros que deben modificarse son:
- Para Spark: *flight_prediction/src/main/scala/es/upm/dit/predictor/MakePrediction.scala* y la construcción del .jar para conectarse a mongo y a kafka.
- Para Kafka: a través de los scripts *bdfi-practicafinal/scripts/startkafka.sh* y *bdfi-practicafinal/scripts/mod-kafka.py* a los que se acceden en la imagen del contenedor, se modificarán los ficheros internos de kafka necesarios para que se conecte con el zookeeper y crear el topic.
- Para Flask: *bdfi-practicafinal/resources/web/predict_flask.py* para enviar las entradas del usuario al topic de kafka y conectarse a mongo para poder hacer polling y recibir la predicción. 
Sin embargo, para poder conectarse, necesitan conocer las direcciones IP interna de los servicios y hasta que no se haga el paso 9 de la siguiente sección no se pueden ver estas direcciones IP. Como solución, se ha optado por pasar las direcciones IP, los puertos y las principales variables de entorno a los contenedores a través de un ConfigMap, el cuál instalaremos en kubernetes tras rellenar las direcciones IP en los pasos 9 y 10 de la siguiente sección.
### Despliegue del sistema
1. Crear un proyecto nuevo en gcloud/Acceder a un proyecto que tengas en gcloud
2. Abrir la terminal
3. Acceder a las credenciales del proyecto
`gcloud config set project project-ID`
4. Establecer la zona horaria donde se va a crear el clúster:
`gcloud config set compute/zone europe-west2-a`
5. Copiar los siguientes ficheros dentro de tu directorio:
    - deployment.yaml
    - configmap.yaml
    - services.yaml
6. Crear clúster:
`gcloud container clusters create bdfi-cluster --num-nodes=5 --max-nodes=8 --min-nodes=3` 
*NOTA: a pesar de tratarse de una práctica y de que valdría con utilizar 2 nodos, hemos decidido que tenga estado dinámico. Para ello, se han definido un número mínimo de nodos, un número máximo y el número de nodos deseados.*
7. Una vez se haya creado el clúster correctamente, acceder a sus credenciales:
`gcloud container clusters get-credentials bdfi-cluster`
8. Crear los services y la regla del firewall para poder acceder al webserver desde el exterior:
`kubectl create -f services.yaml`
`gcloud compute firewall-rules create allow-webserver --allow=tcp:30500`
9. Acceder a los services creados vía comandos o vía interfaz para obtener las direcciones de los endpoints de los pods 
que vamos a crear a continuación
`kubectl get services`
10. Editar el fichero configmap y copiamos las direcciones de kafka, mongo y zookeeper en el *configmap.yaml*
11. Meter el configmap en el clúster y crear los pods:
`kubectl create -f configmap.yaml`
`kubectl create -f deployment.yaml`
12. Esperar a que los contenedores se carguen y ejecuten correctamente.
13. Acceder a la dirección ip del cluster y establecerla como estática:
    - Menú de navegación > Red de VPC > Direcciones IP externas > CAMBIAR a estática
*NOTA: Hay tantas direcciones como nodos configurados. Se puede realizar esta acción en cualquiera de ellos, ya que al haber configurado el servicio del servidor flask como NodePort, cada nodo es un proxy de ese puerto hacia el servicio.*
14. Probar el funcionamiento en: *ip_estática_externa_cluster:30500/flights/delays/predict_kafka*

FOTACA DE QUE FURULAAAAAAA

## Despliegue del escenario completo en Google Cloud con NoMachine


## Autores
- José Antonio Antona Díaz
- Aitor Encinas Alonso 














