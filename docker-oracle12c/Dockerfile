FROM sath89/oracle-12c

MAINTAINER "Rainer Kern <ray@bytewood.com>"
MAINTAINER "Marco Silva <marco.silva@bytewood.com>"

RUN mkdir -p /usr/local/oracle/dumps
RUN chmod -R 0777 /usr/local/oracle/dumps

ADD assets/${DUMP_INIT_SQL} /usr/local/oracle/${DUMP_INIT_SQL}

ADD assets/dumps/${DUMP_FILE} /usr/local/oracle/dumps/${DUMP_FILE}

ADD assets/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

