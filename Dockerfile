FROM openjdk:oraclelinux7

COPY ./kafka_2.13-2.8.0 /kafka_2.13-2.8.0

ENTRYPOINT tail -f /dev/null