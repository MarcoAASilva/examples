## Synopsis

Deploying a Dockerized instance of Oracle12c with automatic import of dump file

## Motivation

Performing backup and restore of state on a Dockerized Oracle12c is useful for automated testing routines.

## Configuring dumps from Host to Container

Set parameters on compose.yml:
- initial sql script
- dump user and password
- dump file

```
ora12c:
  container_name: ora12c
  build:
    .
  dockerfile:
    Dockerfile
  environment:
    - DBCA_TOTAL_MEMORY=1024
    - DUMP_INIT_SQL = init.sql
    - DUMP_USER = test_dpump
    - DUMP_PASSWORD = test
    - DUMP_FILE=test.dmp
  ports:
    - "8080:8080"
    - "1521:1521" 
```


Then run:

```
docker-compose -f ora12c.yml up --build
```

From the parameters above, just connect to your docker-machine ip on port 1521 with test_dump/test.

You should see the test1 table. 

## Moving dumps from Container to Host

After performing changes to the database, connect to the container:

```
docker-exec -it ora12c /bin/bash
```

Export the database state to a known location:

```
$ORACLE_HOME/bin/expdp test_dpump/test directory=DATA_PUMP_DIR dumpfile=newStateTest.dmp
```

Get the back to the host, and run:

```
docker cp ora12c:/u01/app/oracle/admin/xe/dpdump/newStateTest.dmp .
```

The file newStateTest.dmp is now at the current folder.   It may be used as the new starting state, by configuring it on the Docker compose script.



## Customization

### SQL Initializations

This phase runs before the actual call to impdp.

Usually the user gets created, and granted access to folder '/usr/local/oracle/dumps/'.


```
grant create session, create table to test_dpump identified by test;
create or replace directory DATA_PUMP_DIR as '/usr/local/oracle/dumps/';
grant read, write on directory DATA_PUMP_DIR to test_dpump;
```

The script will always copy DUMP_FILE to path '/usr/local/oracle/dumps/' on the container

Adjust init.sql to your needs, or write your own and replace the reference on DUMP_INIT_SQL

### Sample test.dmp

A minimalistic, sample dump file is provided.

This is how it got created.

```
$ORACLE_HOME/bin/sqlplus SYSTEM/ORACLE
```

```
alter user test_dpump default tablespace users quota unlimited on users;
conn test_dpump/test
create table test1 (a1 number);
insert into test1 select level from dual connect by level < 100;
commit;
host
```

```
$ORACLE_HOME/bin/expdp test_dpump/test directory=DATA_PUMP_DIR dumpfile=test.dmp
```

### More sample dumps

Additional dumps can be generated from [Oracle example database schemas](https://github.com/oracle/db-sample-schemas)


## Contributors

Rainer Kern (ray@bytewood.com)
Marco Silva (marco.silva@bytewood.com)

## License

[TBD]

