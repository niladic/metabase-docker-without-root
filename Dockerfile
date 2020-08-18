FROM adoptopenjdk/openjdk11:alpine-jre

ENV FC_LANG en-US
ENV LC_CTYPE en_US.UTF-8

# dependencies
RUN apk add --update --no-cache bash ttf-dejavu fontconfig



ENV MGID=2000
ENV MUID=2000

RUN addgroup -g $MGID -S metabase
RUN adduser -D -u $MUID -G metabase metabase

RUN mkdir /app
RUN chown metabase:metabase /app

ADD https://downloads.metabase.com/v0.36.4/metabase.jar /app/
RUN chown metabase:metabase /app/metabase.jar
RUN chmod 444 /app/metabase.jar

# add our run script to the image
COPY ./run_metabase.sh /app/
RUN chown metabase:metabase /app/run_metabase.sh
RUN chmod +x /app/run_metabase.sh

# create the plugins directory, with writable permissions
RUN mkdir -p /plugins
RUN chmod a+rwx /plugins

# expose our default runtime port
EXPOSE 3000

# if you have an H2 database that you want to initialize the new Metabase
# instance with, mount it in the container as a volume that will match the
# pattern /app/initial*.db:
# $ docker run ... -v $PWD/metabase.db.mv.db:/app/initial.db.mv.db ...



ENV MB_DB_DIR=/metabase-data
ENV MB_DB_FILE=/metabase-data/metabase.db

RUN mkdir $MB_DB_DIR
RUN chown metabase:metabase $MB_DB_DIR


USER metabase


# run it
ENTRYPOINT ["/app/run_metabase.sh"]
