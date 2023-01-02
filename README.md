# PostgREST tutorial and Docker

## About

This repo shows an implementation of most of the details from [PostgREST tutorials 0 & 1](https://postgrest.org/en/stable/tutorials/tut0.html) using Docker and init scripts rather than psql.

## initdb scripts

Remember to make your shell scripts executable `cdmod +x initdb/SCRIPT_NAME.sh`

## Docker

### Start docker containers
`docker compose up -d`

### Stop docker containers
`docker compose down --remove-orphans -v`

### Use psql as super user
`docker exec -it sandbox-db psql -U postgres`

### Use psql as a specific DB and user
`docker exec -it sandbox-db psql -d DB_NAME -U USER_NAME -W`

### pgAdmin host

Instead of "localhost" use "host.docker.internal"