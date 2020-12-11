# kafka_help

-> Criação do process stream

```
mvn archetype:generate \
    -DarchetypeGroupId=org.apache.kafka \
    -DarchetypeArtifactId=streams-quickstart-java \
    -DarchetypeVersion=1.1.0 \
    -DgroupId=br.com.flexvision \
    -DartifactId=stream-netflow \
    -Dversion=0.1 \
    -Dpackage=br.com.flexvision
```

-> Executar o Kafka

1)
```
bin/zookeeper-server-start.sh config/zookeeper.properties
bin/zookeeper-server-start.sh config/zookeeper.properties &
bin/zookeeper-server-start.sh -daemon config/zookeeper.properties
```

2)

```
bin/kafka-server-start.sh config/server.properties
bin/kafka-server-start.sh config/server.properties &
bin/kafka-server-start.sh -daemon config/server.properties
```

-> Memoria para o Kafka

```
export KAFKA_HEAP_OPTS="-Xmx8g -Xms8g -XX:MetaspaceSize=96m -XX:+UseG1GC -XX:MaxGCPauseMillis=20 -XX:InitiatingHeapOccupancyPercent=35 -XX:G1HeapRegionSize=16M -XX:MinMetaspaceFreeRatio=50 -XX:MaxMetaspaceFreeRatio=80"
```

-> Criação do topic

```
bin/kafka-topics.sh --create \
    --zookeeper localhost:2181 \
    --replication-factor 1 \
    --partitions 30 \
    --config cleanup.policy=delete \
    --topic streams-flow-input
```

```
bin/kafka-topics.sh --create \
    --zookeeper localhost:2181 \
    --replication-factor 1 \
    --partitions 30 \
    --config cleanup.policy=delete \
    --topic streams-flow-output
    --config retention.ms=300000 \
```

-> Consulta do topic

```
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
    --topic streams-flow-output \
    --from-beginning \
    --formatter kafka.tools.DefaultMessageFormatter \
    --property print.key=true \
    --property print.value=true \
    --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --property value.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
	--group group-output-flow
```

```
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
    --topic streams-flow-input \
    --from-beginning \
    --formatter kafka.tools.DefaultMessageFormatter \
    --property print.key=true \
    --property print.value=true \
    --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --property value.deserializer=org.apache.kafka.common.serialization.StringDeserializer
```

-> Describe (DefiniÃ§Ã£o)

* Grupo de consumidor

```
bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --describe --group group-output-flow
bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --describe --group consumer_group_flow
```

* Topicos

```
bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic streams-flow-output
bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic streams-flow-input
bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic streams-netflow-time-windowed-aggregated-stream-store-changelog
```

-> ExclusÃ£o do topic

```
bin/kafka-topics.sh --zookeeper localhost:2181 --delete --topic streams-flow-input
bin/kafka-topics.sh --zookeeper localhost:2181 --delete --topic streams-flow-output
bin/kafka-topics.sh --zookeeper localhost:2181 --delete --topic streams-netflow-time-windowed-aggregated-stream-store-changelog
bin/kafka-topics.sh --zookeeper localhost:2181 --delete --topic streams-netflow-flow-aggregated-store-changelog
```

-> ConfiguraÃ§Ã£o Kafka

```
bin/zookeeper-shell.sh localhost
```


/* ConfiguraÃ§Ãµes de topic */
--config <String: name=value>

A topic configuration override for the topic being created or altered.The following is a list of valid configurations:

```                      
cleanup.policy
compression.type
delete.retention.ms
file.delete.delay.ms
flush.messages
flush.ms
follower.replication.throttled.replicas
index.interval.bytes
leader.replication.throttled.replicas
max.message.bytes
message.format.version
message.timestamp.difference.max.ms
message.timestamp.type
min.cleanable.dirty.ratio
min.compaction.lag.ms
min.insync.replicas
preallocate
retention.bytes
retention.ms
segment.bytes
segment.index.bytes
segment.jitter.ms
segment.ms
unclean.leader.election.enable
```