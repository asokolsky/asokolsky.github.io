# PSQL Client

## On MacOS

https://stackoverflow.com/questions/44654216/correct-way-to-install-psql-without-full-postgres-on-macos

```sh
brew install libpq
```

Then:
```sh
brew link --force libpq
```

## In a container

Set the context:
```
PSQL_USER=user \
PSQL_PASSWORD=password \
PSQL_HOST=datamart.rds.amazonaws.com \
PSQL_PORT=5432 \
PSQL_DB=db_default
```

Then:
```
docker run -it --rm jbergknoff/postgresql-client \
  "postgresql://${PSQL_USER}:${PSQL_PASSWORD}@${PSQL_HOST}:${PSQL_PORT}/${PSQL_DB}" \
  -P pager=off -c "select count(*) from pg_class"
```

## Interactive PQSL Commands

See the [cheat sheet](./psql-commands.md)
