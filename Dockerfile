FROM alpine:latest

ENV DBUSER root
ENV DBPASS password
ENV DBNAME documize
ENV DBHOST localhost
ENV DBSALT 1234567890abcdefg

RUN apk --update add \
    wget 

WORKDIR /documize

RUN wget https://community-downloads.s3.us-east-2.amazonaws.com/documize-community-plus-linux-amd64
RUN chmod +x /documize/documize-community-plus-linux-amd64
EXPOSE 5001

CMD /documize/documize-community-plus-linux-amd64 -port=5001 -db="$DBUSER:$DBPASS@tcp($DBHOST:3306)/$DBNAME" -dbtype=percona -salt=$DBSALT
