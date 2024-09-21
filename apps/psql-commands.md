# PSQL Commands Cheat Sheet

From [this cheat sheet](http://www.postgresonline.com/special_feature.php?sf_name=postgresql83_psql_cheatsheet).

## CLI
```
psql [OPTIONS]... [DBNAME [USERNAME]]

General options:
  -c COMMAND
  -d, --dbname=NAME
  -f, --file=FILENAME
  --help
  -l, --list
  -v NAME=VALUE
  --version
  -X

  run only single command (SQL or internal) and exit
  specify database name to connect to (default: "logged in username here")
  execute commands from file, then exit
  show this help, then exit
  list available databases, then exit
  set psql variable NAME to VALUE
  output version information, then exit
  do not read startup file (~/.psqlrc)

Connection options

-h, --host=HOSTNAME      database server host or socket directory
-p, --port=PORT          database server port number
-U, --username=NAME      connect as specified database user
-W, --password           force password prompt (should happen automatically)
-e, --exit-on-error      exit on error, default is to continue
-d DBNAME                some database
```

### Examples

Restore the whole server:
```sh
psql --host=localhost --username=someuser -f /path/to/pgdumpall.sql
```
Run an sql batch script against a database:
```sh
psql -h localhost -U someuser -d somedb -f /path/to/somefile.sql
```

Run an sql batch script against a database and send output to file:
```sh
psql -h localhost -U someuser -d somedb -f /path/to/scriptfile.sql  -o /path/to/outputfile.txt
```
Run a single query against a db:
```sh
psql -U postgres -d pagila -c "CREATE TABLE test(some_id serial PRIMARY KEY, some_text text);"
```

Output data in html format:
```sh
psql -h someserver -p 5432 -U someuser -d somedb -H -c "SELECT * FROM sometable" -o mydata.html
```

## Interactive Console


Command|Description
-------|-----------
`\copyright`|for distribution terms
`\h`|for help with SQL commands
`\?`|for help with psql commands
`\g`|or terminate with semicolon to execute query
`\q`|to quit
General|&nbsp;
`\c [DBNAME |- USER|- HOST|- PORT|-]`|connect to new database
`\cd [DIR]`|change the current working directory
`\encoding [ENCODING]`|show or set client encoding
`\h [NAME]`|help on syntax of SQL commands, * for all commands
`\set [NAME [VALUE]]`|set internal variable, or list all if no parameters
`\timing`|toggle timing of commands (currently off)
`\unset NAME`|unset (delete) internal variable
`\prompt [TEXT] NAME`|prompt user to set internal variable
`\! [COMMAND]`|execute command in shell or start interactive shell
Query Buffer|&nbsp;
`\e [FILE]`|edit the query buffer (or file) with external editor
`\g [FILE]`|send query buffer to server (and results to file or |pipe)
`\p`|show the contents of the query buffer
`\r`|reset (clear) the query buffer
`\w FILE`|write query buffer to file
Input/Output|&nbsp;
`\echo [STRING]`|write string to standard output
`\i FILE`|execute commands from file
`\o [FILE]`|send all query results to file or |pipe
`\qecho [STRING]`|write string to query output stream (see \o)
INFORMATIONAL|&nbsp;
`\d [NAME]`|??
`\d{t|i|s|v|S} [PATTERN]`|(add "+" for more detail)
`\da [PATTERN]`|??
`\db [PATTERN]`|??
`\dc [PATTERN]`|??
`\dC`|??
`\dd [PATTERN]`|??
`\dD [PATTERN]`|??
`\df [PATTERN]`|??
`\dF [PATTERN]`|??
`\dFd [PATTERN]`|??
`\dFt [PATTERN]`|??
`\dFp [PATTERN]`|??
`\dg [PATTERN]`|??
`\dn [PATTERN]`|??
`\do [NAME]`|??
`\dl`|??
`\dp [PATTERN]`|??
`\dT [PATTERN]`|??
`\du [PATTERN]`|??
`\l`|??
`\z [PATTERN]`|??

```
describe table, index, sequence, or view
list tables/indexes/sequences/views/system tables
list aggregate functions
list tablespaces (add "+" for more detail)
list conversions
list casts
show comment for object
list domains
list functions (add "+" for more detail)
list text search configurations (add "+" for more detail)
list text search dictionaries (add "+" for more detail)
list text search templates
list text search parsers (add "+" for more detail)
list groups
list schemas (add "+" for more detail)
list operators
list large objects, same as \lo_list
list table, view, and sequence access privileges
list data types (add "+" for more detail)
list users
list all databases (add "+" for more detail)
list table, view, and sequence access privileges (same as \dp)

FORMATTING
  \a
  \C [STRING]
  \f [STRING]
  \H
  \pset NAME [VALUE]


  \t
  \T [STRING]
  \x
```

```
toggle between unaligned and aligned output mode
set table title, or unset if none
show or set field separator for unaligned query output
toggle HTML output mode (currently off)
set table output option
  (NAME := {format|border|expanded|fieldsep|footer|null|numericlocale|recordsep
  |tuples_only|title|tableattr|pager})
show only rows (currently off)
set HTML <table> tag attributes, or unset if none
toggle expanded output (currently off)


COPY, LARGE OBJECT
  \copy ...
  \lo_export LOBOID FILE
  \lo_import FILE [COMMENT]
  \lo_list
  \lo_unlink LOBOID

perform SQL COPY with data stream to the client host
LOBOID FILE
FILE [COMMENT]

large object operations
```

### More Examples

Launch Interactive session:
```sh
psql -h localhost -U postgres -d somedb
```
View help for SELECT * LIMIT:
```
\h  SELECT * LIMIT
```

List all the tables in db with descriptions:
```
\dt+
```

List all the tables in db with s in the name:
```
\dt *s*
```

Cancel out of MORE screen:
```
:q
```
