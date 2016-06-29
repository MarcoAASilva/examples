FROM sath89/oracle-12c

MAINTAINER "Rainer Kern <ray@bytewood.com>"
MAINTAINER "Marco Silva <marco.silva@bytewood.com>"

RUN mkdir -p /usr/local/oracle/dumps
RUN chmod -R 0777 /usr/local/oracle/dumps

ADD assets/init.sql /usr/local/oracle/init.sql

ADD assets/dumps/dump_after_migration_fresh_config_v4.dmp /usr/local/oracle/dumps/dump_after_migration_fresh_config_v4.dmp


