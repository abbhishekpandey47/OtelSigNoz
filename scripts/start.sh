#!/bin/bash

[ -z "$JAVA_XMS" ] && JAVA_XMS=512m
[ -z "$JAVA_XMX" ] && JAVA_XMX=512m

set -e

 # OpenTelemetry:
 # https://github.com/open-telemetry/opentelemetry-java-instrumentation
 JAVA_OPTS="${JAVA_OPTS} \
   -Xms${JAVA_XMS} \
   -Xmx${JAVA_XMX} \
   -Dapplication.name=demo-application \
   -Dotel.metrics.exporter=none \
   -Dotel.traces.exporter=otlp \
   -Dotel.resource.attributes=service.name=demo-service-java \  
   -Dotel.exporter.otlp.traces.endpoint=http://localhost:4317 \
   -Dotel.service.name=demo-service \
   -Dotel.javaagent.debug=false \
   -javaagent:../agents/opentelemetry-javaagent.jar"

exec java ${JAVA_OPTS} -jar "../target/demo-0.0.1.jar"