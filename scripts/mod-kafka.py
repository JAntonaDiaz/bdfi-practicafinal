import os
f = open("/main/kafka_2.12-3.1.2/config/server.properties", "w")
zookeeper_host = os.getenv('ZOOKEPER_HOST')
zookeeper_port = os.getenv('ZOOKEPER_PORT')
kafka_host = os.getenv('KAFKA_HOST')
kafka_port = os.getenv('KAFKA_PORT')
f.write("broker.id=0"+"\n")
f.write("listeners=PLAINTEXT://:" + kafka_port +"\n")
f.write("advertised.listeners=PLAINTEXT://" + kafka_host + ":" + kafka_port +"\n")
f.write("num.network.threads=3"+"\n")
f.write("num.io.threads=8"+"\n")
f.write("socket.send.buffer.bytes=102400"+"\n")
f.write("socket.receive.buffer.bytes=102400"+"\n")
f.write("socket.request.max.bytes=104857600"+"\n")
f.write("log.dirs=/tmp/kafka-logs"+"\n")
f.write("num.partitions=1"+"\n")
f.write("num.recovery.threads.per.data.dir=1"+"\n")
f.write("offsets.topic.replication.factor=1"+"\n")
f.write("transaction.state.log.replication.factor=1"+"\n")
f.write("transaction.state.log.min.isr=1"+"\n")
f.write("log.retention.hours=168"+"\n")
f.write("log.segment.bytes=1073741824"+"\n")
f.write("log.retention.check.interval.ms=300000"+"\n")
f.write("zookeeper.connect=" + zookeeper_host + ":" + zookeeper_port +"\n")
f.write("zookeeper.connection.timeout.ms=18000"+"\n")
f.write("group.initial.rebalance.delay.ms=0"+"\n")
f.close()
