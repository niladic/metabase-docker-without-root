#!/bin/bash


# Setup Java Options
JAVA_OPTS="${JAVA_OPTS} -XX:+IgnoreUnrecognizedVMOptions"
JAVA_OPTS="${JAVA_OPTS} -Dfile.encoding=UTF-8"
JAVA_OPTS="${JAVA_OPTS} -Dlogfile.path=target/log"
JAVA_OPTS="${JAVA_OPTS} -server"

if [ ! -z "$JAVA_TIMEZONE" ]; then
    JAVA_OPTS="${JAVA_OPTS} -Duser.timezone=${JAVA_TIMEZONE}"
fi


# Launch the application
# exec is here twice on purpose to  ensure that metabase runs as PID 1 (the init process)
# and thus receives signals sent to the container. This allows it to shutdown cleanly on exit
exec /bin/sh -c "exec java $JAVA_OPTS -jar /app/metabase.jar $@"
