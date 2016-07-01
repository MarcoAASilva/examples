## Synopsis

Deploying a Dockerized instance of Oracle12c with backup and restore of state via dump file

## Code Example

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
    - DUMP_USER = DFOX
    - DUMP_PASSWORD = developer
    - DUMP_FILE=dump_after_migration_fresh_config_v4.dmp
  ports:
    - "8080:8080"
    - "1521:1521" 
```


docker-compose -f ora12c.yml up --build

## Motivation

Performing backup and restore of state on a Dockerized Oracle12c is useful for automated testing routines.

## Installation

[TBD]

## Contributors

[TBD]


## License

[TBD]

